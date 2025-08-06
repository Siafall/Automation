from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from SeleniumLibrary import SeleniumLibrary

class CustomSeleniumLibrary:
    """
    A custom library to extend SeleniumLibrary with custom keywords.
    """
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    @property
    def selenium_instance(self):
        # This allows the custom library to access all keywords from SeleniumLibrary
        return BuiltIn().get_library_instance('SeleniumLibrary')

    @keyword("Wait For Alert And Check Text")
    def wait_for_alert_and_check_text(self, expected_text):
        """
        Waits for a JavaScript alert to appear and verifies its text.
        Then accepts the alert.
        """
        # Corrected logic: wait for the alert, then check its text
        self.selenium_instance.wait_for_alert(timeout=10)
        self.selenium_instance.alert_should_be_present(expected_text)
        self.selenium_instance.handle_alert(action="ACCEPT")

    @keyword("Wait For Element And Click")
    def wait_for_element_and_click(self, locator):
        """
        Waits for an element to be visible and then clicks it.
        """
        self.selenium_instance.wait_until_element_is_visible(locator)
        self.selenium_instance.click_element(locator)