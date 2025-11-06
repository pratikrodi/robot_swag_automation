*** Settings ***
Documentation     Advanced Robot Framework Project - SauceDemo
Resource          ../resources/swag_keywords.robot
Test Setup      Open Browser To Swag Labs
Test Teardown   Close All Browser
Suite Teardown    Capture Page Screenshot

*** Test Cases ***

Valid Login Test
    [Documentation]    Test login with valid credentials
    Login With Credentials    ${VALID_USER}    ${VALID_PASS}
    Verify Successful Login

Invalid Login Test
    [Documentation]    Test login with invalid credentials
    Login With Credentials    ${INVALID_USER}    ${INVALID_PASS}
    Verify Invalid Login Message

Add To Cart Test
    [Documentation]    Verify adding products to cart works correctly
    Login With Credentials    ${VALID_USER}    ${VALID_PASS}
    Add Products To Cart
    Go To Cart
    Verify Cart Items
    Logout From Application

Empty Cart Test
    [Documentation]    Verify empty cart shows no items
    Login With Credentials    ${VALID_USER}    ${VALID_PASS}
    Go To Cart
    Page Should Not Contain Element    xpath://div[@class='cart_item']
    Logout From Application