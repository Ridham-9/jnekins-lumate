*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    ImapLibrary2
Library    String
Library    OperatingSystem
Library    pyperclip
Library    Collections
Library    ../PythonLib/copy-paste.py    WITH NAME    CustomKeywords
Resource   ../Locators/lumate2Locator.robot

*** Keywords ***

Open LUMCARE url on browser
#    Open Browser With Options    ${P_PORTAL_URL}    ${CHROME_OPTIONS}
    Open Chrome Browser
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_PAGE_P_PORTAL}    15s


#Open Browser With Options
#    [Arguments]    ${url}    ${options}
#    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#    ${options_list}=    Split String    ${options}    ${SPACE}
#    FOR    ${option}    IN    @{options_list}
#        Call Method    ${chrome options}    add_argument    ${option}
#    END
#    Create WebDriver    Chrome    options=${chrome options}
#    Go To    ${url}

Open Chrome Browser
    [Documentation]    Open Chrome browser with specific options
    Set Environment Variable    webdriver.chrome.driver    ${CHROME_DRIVER_PATH}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    ${CHROME_OPTIONS}
    Open Browser    ${P_PORTAL_URL}    chrome    options=${options}


Fill the credentials and login
    Input Text        ${USERNAME_PATH_P_PORTAL}    ${USERNAME_P_PORTAL}
    Input Password    ${PASSWORD_PATH_P_PORTAL}    ${PASSWORD_P_PORTAL}
    Click Element     ${REMEMBER_ME}
    Wait Until Element Is Visible    ${LOGIN_BTN}
    Click Element     ${LOGIN_BTN}

Enter OTP and Submit it
    ${otp}=  Wait for OTP Email
#    CustomKeywords.Copy To Clipboard     ${otp}
    wait until element is enabled        ${OTP_P_PORTAL}    ${TIMEOUT}
#    Input Text    ${OTP_P_PORTAL}    ${otp}
#    Press Keys                           ${OTP_P_PORTAL}    CTRL+V
    FOR    ${i}    IN RANGE    1    7
        Input Text    ${OTP_P_PORTAL}/input[${i}]    ${otp}[${i-1}]
    END
#    Input Text    ${OTP_P_PORTAL}    ${otp}
#    Click Element                        ${OTP_P_PORTAL}
#    CustomKeywords.Paste From Clipboard
    Wait Until Element Is Enabled        ${VALIDATE_OTP}
    Click Element                        ${VALIDATE_OTP}
    Wait Until Element Is Visible        ${SELECT_DEPENDENT}    15s
    ${home}=    Run Keyword And Return Status    Page Should Not Contain    Please select any one dependent to proceed further
    Run Keyword If    ${home}    Enter OTP And Submit It

Select Dependent and Skip profile editing
    Wait Until Element Is Visible        ${SELECT_DEPENDENT}    15s
    Click Element                        ${SELECT_DEPENDENT}
    Wait Until the Update Icon Disappear
    Wait Until Element Is Visible        ${SKIP}    15s
    Click Element    ${SKIP}
    Wait Until The Update Icon Disappear

Wait for OTP Email
    Open Mailbox    host=${EMAIL_SERVER}   user=${EMAIL_USERNAME}   password=${EMAIL_PASSWORD}
    ${email_index}=    Wait For Email   sender=${SENDER_USERNAME}  status=UNSEEN   timeout=300
    ${email_body}=      Get Email Body    ${email_index}
    ${otp}=    Get Regexp Matches    ${email_body}    \\b\\d{6}\\b
    Delete Email    ${email_index}
    Log               OTP received: ${otp}
    RETURN          ${otp}[3]



Wait Until the Update Icon Disappear
    Wait Until Element Is Not Visible  ${UpdateIcon}    ${TIMEOUT}


Payment Of Clinician1
    Wait Until Element Is Visible    ${BILLING_SECTION}
    Wait Until The Update Icon Disappear
    Click Element                        ${BILLING_SECTION}
    Wait Until Element Is Visible        ${BILLING_PAGE}    ${TIMEOUT}
    Wait Until the Update Icon Disappear
    Click Button                         ${PAY1}
    Wait Until the Update Icon Disappear
    Sleep    5s
#    Wait Until Element Is Visible        ${ADD_NEW_CARD}    ${TIMEOUT}
    Click Element                        ${ADD_NEW_CARD}
    Wait Until the Update Icon Disappear
#    Wait Until Element Is Visible        ${CARD_NUMBER_PATH}    ${TIMEOUT}
#    Mouse Over    ${CARD_NUMBER_PATH}
#    Click Element    ${CARD_NUMBER_PATH}
#    Input Text        ${CARD_NUMBER_PATH}    ${CARD_NUMBER}
#    Input Text                           ${CARD_EXPIRY_PATH}    ${CARD_EXPIRY}
#    Input Text                           ${CARD_CVC_PATH}    ${CARD_CVC}
    Input Text                           ${NAME_ON_CARD_PATH}    ${NAME_ON_CARD}

