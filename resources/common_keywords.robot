*** Settings ***
Library    SeleniumLibrary
Library    ../libraries/CustomSeleniumLibrary.py
Library    ../libraries/VisualComparator.py
Resource   locators.robot
Resource   data.robot
Variables  ../config/settings.py


*** Keywords ***
Wait For Element And Click
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Click Element    ${locator}

Wait For Alert And Check Text
    [Arguments]    ${expected_text}    ${timeout}=10
    ${alert_text}=    Handle Alert    action=ACCEPT    timeout=${timeout}
    Should Be Equal    ${alert_text}    ${expected_text}
	
Open Browser To Home Page
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    10s

Open Browser To Login Page
    [Documentation]    Navigates to the home page and opens the login modal.
    Open Browser To Home Page
    Click Link    ${LOG_IN_LINK}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_FIELD}

Input Username
    [Arguments]    ${username}
    Input Text    ${LOGIN_USERNAME_FIELD}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${password}

Click Login Button
    Click Button    ${LOGIN_BUTTON}

Verify User Is Logged In
    Wait Until Element Is Visible    ${WELCOME_USER_LABEL}
    Element Should Contain    ${WELCOME_USER_LABEL}    Welcome ${VALID_USERNAME}
	
Take Visual Snapshot
    [Arguments]    ${name}
    Capture Page Screenshot    ${name}.png
	
Capture Element Screenshot
    [Arguments]    ${locator}    ${filename}
    ${path}=    Set Variable    ${OUTPUT_DIR}/screenshots/${filename}
    Capture Element Screenshot    ${locator}    ${path}

Compare Images
    [Arguments]    ${filename}    ${threshold}=0.95
    ${baseline}=    Set Variable    ${OUTPUT_DIR}/baseline/${filename}
    ${current}=    Set Variable    ${OUTPUT_DIR}/screenshots/${filename}
    
    # Create baseline if doesn't exist
    Run Keyword Unless    File Exists ${baseline}
    ...    Copy File    ${current}    ${baseline}
    
    # Compare images using Python library
    ${diff}=    Compare Images Python    ${baseline}    ${current}    ${threshold}
    Should Be True    ${diff} <= ${threshold}
	
Get Image Size
    [Arguments]    ${image_path}
    ${img}=    Evaluate    Image.open(r"${image_path}")    modules=PIL.Image
    ${size}=    Evaluate    str($img.size)
    [Return]    ${size}