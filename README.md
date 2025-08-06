# E-commerce UI Automation with Robot Framework & Visual Validation 🛒

This project is a comprehensive automation framework for the DemoBlaze e-commerce website (https://www.demoblaze.com/). It uses **Robot Framework**, **Python**, and **Selenium** to automate UI tests. The framework is designed for **maintainability**, **scalability**, and **reusability**, and includes a custom Python library for **AI-enhanced visual regression testing**.

## Prerequisites
To run this project, you'll need the following:
- **Python 3.8+**
- **pip** (Python package installer)
- **A modern web browser** (e.g., Chrome)
- **The corresponding WebDriver** for your browser (e.g., `chromedriver`). Starting with Selenium 4.6, the driver is often managed automatically, but manual setup is still good practice for reliability.

## Setup and Installation

1.  **Create the project directory structure** as shown in the project overview.
2.  **Open a terminal** and navigate to the project's root directory (`Automation`).
3.  **Install Python Dependencies:**
    ```bash
    pip install -r requirements.txt
    ```
4.  **Download WebDriver Executable (Optional but Recommended):**
    - Go to the official download page for your browser's WebDriver (e.g., [ChromeDriver](https://googlechromelabs.github.io/chrome-for-testing/)).
    - Download the version that matches your installed browser.
    - Place the executable file (e.g., `chromedriver.exe` or `chromedriver`) inside the `drivers/` directory. If you skip this, Selenium may download it automatically.

## How to Run Tests
From the project root directory, use the `robot` command.

### Run all tests in the project
```bash
robot --pythonpath . tests
