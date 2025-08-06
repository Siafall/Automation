*** Variables ***
# Login Page Elements
${LOG_IN_LINK}            id:login2
${LOGIN_USERNAME_FIELD}   id:loginusername
${LOGIN_PASSWORD_FIELD}   id:loginpassword
${LOGIN_BUTTON}           css:button[onclick='logIn()']
${WELCOME_USER_LABEL}     id:nameofuser

# Product Page Elements
${PHONES_CATEGORY_LINK}      xpath://a[contains(.,'Phones')]
${LAPTOPS_CATEGORY_LINK}     xpath://a[contains(.,'Laptops')]
${MONITORS_CATEGORY_LINK}    xpath://a[contains(.,'Monitors')]
${PRODUCT_CARD}              css:.card-block
${PRODUCT_NAME}              css:.card-title
${PRODUCT_PRICE}             css:.card-price
${PRODUCT_DESCRIPTION}       css:.card-text
${ADD_TO_CART_BUTTON}        xpath://a[contains(.,'Add to cart')]
${CART_LINK}                 id:cartur
${FIRST_PRODUCT}             xpath:(//a[@class="hrefch"])[1]
${PRODUCT_GRID}              css:.card-block
${PRODUCT_TITLE}             css:.name
${PHONES_CATEGORY_URL}    ${BASE_URL}/index.html#/category/phones