*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}               https://www.saucedemo.com/
${BROWSER}           edge
${VALID_USER}        standard_user
${VALID_PASS}        secret_sauce
${INVALID_USER}      wrong_user
${INVALID_PASS}      wrong_pass

*** Keywords ***
Open Browser To Swag Labs
    [Documentation]    Open browser and navigate to login page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Text    id:user-name    ${username}
    Input Text    id:password     ${password}
    Click Button  id:login-button

Verify Successful Login
    Page Should Contain Element    css:.inventory_list

Verify Invalid Login Message
    Page Should Contain Element    css:h3[data-test="error"]
    Element Text Should Be    css:h3[data-test="error"]    Epic sadface: Username and password do not match any user in this service

Add Products To Cart
    Click Button    xpath://button[@data-test='add-to-cart-sauce-labs-backpack']
    Click Button    xpath://button[@data-test='add-to-cart-sauce-labs-bike-light']

Go To Cart
    Click Element   class:shopping_cart_link

Verify Cart Items
    Page Should Contain Element    xpath://div[@class='cart_item']
    ${count}=    Get Element Count    xpath://div[@class='cart_item']
    Should Be True    ${count} > 0

Logout From Application
    Click Element   id:react-burger-menu-btn
    Wait Until Element Is Visible   id:logout_sidebar_link  timeout=10s
    Wait Until Keyword Succeeds     1   3   Click Element   id:logout_sidebar_link
    Page Should Contain Element    id:login-button

Close All Browser
    Close Browser
