*** Settings ***
Library   Browser    jsextension=${EXECDIR}/resources/module.js

Task Teardown    Finish session

*** Test Cases ***
Deve tocar uma música
    [Tags]    player
    New Browser    browser=chromium    headless=False        
    New Page    https://parodify.vercel.app/
    Get Text    css=.logged-user    contains    Fernando Papito

    ${PLAY}    Get play song    Bughium 
    Wait For Elements State    ${PLAY}    visible    timeout=10s
    Click   ${PLAY}

    ${PAUSE}   Get pause song    Bughium
    Wait For Elements State    ${PAUSE}    visible    timeout=10s
    Sleep    10  

Deve tocar uma música com massa mocada
    [Tags]    player_mock

    ##massa de teste
    ${PLAY}   Get play song    Smells Like Test Script
    ${PAUSE}  Get pause song    Smells Like Test Script

    New Browser    browser=chromium    headless=False        
    New Page    about:blank
    
    #ouvindo a rota /song para interceptar a música e "trolar"  a massa de teste
    MockMySong

    Go To    https://parodify.vercel.app/
    Get Text    css=.logged-user    contains    Fernando Papito

    
    Wait For Elements State    ${PLAY}    visible    timeout=10s
    Click   ${PLAY}

    
    Wait For Elements State    ${PAUSE}    visible    timeout=5
    Wait For Elements State   ${PLAY}    visible    timeout=7

*** Keywords ***

Get play song 
    [Arguments]    ${song_name}
    ${play}    Set Variable    
    ...    xpath=//div[contains(@class,"song")]//h6[text()="${song_name}"]/..//button[contains(@class,"play")]
    RETURN    ${play}

Get pause song
    [Arguments]    ${song_name}
    ${pause}    Set Variable
    ...    xpath=//div[contains(@class,"song")]//h6[text()="${song_name}"]/..//button[contains(@class,"pause")]
    RETURN    ${pause}

Finish session
    Take Screenshot  
   