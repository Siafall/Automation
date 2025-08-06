import os
from PIL import Image, ImageChops

# Robot Framework class name must match the file name
class VisualComparator:
    """
    A custom library for performing visual regression testing using image comparison.
    It takes screenshots and compares them against baseline images to detect UI changes.
    """
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    BASE_PATH = os.path.join(os.path.dirname(__file__), '..', 'screenshots')

    def __init__(self):
        self._baseline_dir = os.path.join(self.BASE_PATH, 'baseline')
        self._actual_dir = os.path.join(self.BASE_PATH, 'actual')
        os.makedirs(self._baseline_dir, exist_ok=True)
        os.makedirs(self._actual_dir, exist_ok=True)
        self.selenium_library = None

    @property
    def selenium_instance(self):
        # Get the current SeleniumLibrary instance to use its methods
        if not self.selenium_library:
            from robot.libraries.BuiltIn import BuiltIn
            self.selenium_library = BuiltIn().get_library_instance('SeleniumLibrary')
        return self.selenium_library

    def _save_screenshot(self, name, directory):
        """Internal keyword to save a screenshot with a given name."""
        file_path = os.path.join(directory, f"{name}.png")
        self.selenium_instance.capture_page_screenshot(file_path)
        return file_path

    def take_visual_snapshot(self, snapshot_name):
        """
        Takes a full page screenshot and saves it to the actuals folder.
        If a baseline image does not exist, it saves the current screenshot as the baseline.
        """
        actual_path = self._save_screenshot(snapshot_name, self._actual_dir)
        baseline_path = os.path.join(self._baseline_dir, f"{snapshot_name}.png")
        
        if not os.path.exists(baseline_path):
            print(f"Baseline not found. Saving current image as baseline: {baseline_path}")
            Image.open(actual_path).save(baseline_path)
    
    def compare_visual_snapshot(self, snapshot_name, threshold=0.1):
        """
        Compares a new screenshot against an existing baseline image.
        Fails the test if the difference percentage exceeds the given threshold.
        """
        baseline_path = os.path.join(self._baseline_dir, f"{snapshot_name}.png")
        
        if not os.path.exists(baseline_path):
            raise FileNotFoundError(f"Baseline image not found: {baseline_path}")

        actual_path = self._save_screenshot(snapshot_name, self._actual_dir)

        baseline_img = Image.open(baseline_path)
        actual_img = Image.open(actual_path)
        
        # Ensure images have the same dimensions before comparison
        if baseline_img.size != actual_img.size:
            raise AssertionError(f"Image dimensions do not match! Baseline: {baseline_img.size}, Actual: {actual_img.size}")
            
        diff = ImageChops.difference(baseline_img, actual_img)
        diff_count = sum(1 for pixel in diff.getdata() if pixel != (0, 0, 0))
        total_pixels = diff.width * diff.height
        
        difference_percentage = (diff_count / total_pixels) * 100
        
        print(f"Visual difference for '{snapshot_name}': {difference_percentage:.2f}%")
        
        if difference_percentage > threshold:
            # Save a diff image to highlight discrepancies
            diff.save(os.path.join(self._actual_dir, f"{snapshot_name}_diff.png"))
            raise AssertionError(f"Visual regression detected! Difference is {difference_percentage:.2f}% (above threshold of {threshold:.2f}%).")
            
    def take_element_screenshot_and_compare(self, locator, snapshot_name, threshold=0.1):
        """
        Takes a screenshot of a specific element and compares it to a baseline.
        """
        element = self.selenium_instance.get_webelement(locator)
        element.screenshot(os.path.join(self._actual_dir, f"{snapshot_name}.png"))
        self.compare_visual_snapshot(snapshot_name, threshold)
