*** Settings ***
Library   Browser

*** Test Cases ***
Deve tocar uma música
    [Tags]    player
    New Browser    browser=chromium    headless=False        
    New Page    https://parodify.vercel.app/
    Get Text    css=.logged-user    contains    Fernando Papito

    ${play}    Set Variable    
    ...    xpath=//div[contains(@class,"song")]//h6[text()="Bughium"]/..//button[contains(@class,"play")]

    Wait For Elements State    ${play}    visible    timeout=10s
    Click   ${play}
    Sleep    10  