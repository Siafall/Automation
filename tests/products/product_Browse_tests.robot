*** Settings ***
Documentation     Suite to test user authentication on DemoBlaze.
Resource          ../../resources/common_keywords.robot
Resource          ../../resources/locators.robot
Suite Setup       Open Browser To Home Page
Suite Teardown    Close Browser

*** Test Cases ***
Browse Products By Category
    [Documentation]    Verifies product category navigation
    Wait For Element And Click    ${PHONES_CATEGORY_LINK}    15s
    Wait Until Page Contains Element    css:.card-block    timeout=15s
    Page Should Contain    Samsung galaxy s6
    
    Go To    ${BASE_URL}
    Wait For Element And Click    ${LAPTOPS_CATEGORY_LINK}    15s
    Wait Until Page Contains Element    css:.card-block    timeout=15s
    Page Should Contain    Sony vaio i5

View Product Details And Add To Cart
    [Documentation]    Tests product details and cart addition
    Wait For Element And Click    ${PHONES_CATEGORY_LINK}
    Wait Until Page Contains Element    ${FIRST_PRODUCT}
    Wait For Element And Click    ${FIRST_PRODUCT}
    Wait Until Element Is Visible    ${PRODUCT_TITLE}
    Wait For Element And Click    ${ADD_TO_CART_BUTTON}
    Alert Should Be Present    Product added    action=ACCEPT

Navigate Back From Product Page
    [Documentation]    Tests back navigation
    # Use direct navigation to category first
    Go To    ${BASE_URL}/index.html#/category/phones
    Wait Until Page Contains Element    ${FIRST_PRODUCT}    timeout=15
    Click Element    ${FIRST_PRODUCT}
    Wait Until Element Is Visible    ${PRODUCT_TITLE}    timeout=15
    
    # Use JavaScript navigation for more reliable back
    Execute JavaScript    window.history.back()
    Wait Until Page Contains    Phones    timeout=15