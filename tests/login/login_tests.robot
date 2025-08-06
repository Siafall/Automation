*** Settings ***
Documentation     Suite to test product browsing and cart functionality on DemoBlaze.
Resource          ../../resources/common_keywords.robot
Resource          ../../resources/locators.robot
Suite Setup       Open Browser To Home Page
Suite Teardown    Close Browser

*** Test Cases ***
Successful User Login
    [Documentation]    Verifies that a user can successfully log in with valid credentials.
    [Tags]             login    smoke
    Open Browser To Login Page
    Input Username    ${VALID_USERNAME}
    Input Password    ${VALID_PASSWORD}
    Click Login Button
    Verify User Is Logged In
    Take Visual Snapshot    Logged_In_Homepage

Invalid User Login
    [Documentation]    Tests the login functionality with invalid credentials to ensure it fails as expected.
    [Tags]             login    negative
    Open Browser To Login Page
    Input Username     ${INVALID_USERNAME}
    Input Password     ${INVALID_PASSWORD}
    Wait For Element And Click    ${LOGIN_BUTTON}
    Alert Should Be Present    Wrong password.    action=ACCEPT

