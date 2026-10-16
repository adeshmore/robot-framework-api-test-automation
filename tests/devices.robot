
*** Settings ***
Documentation     Robot Framework tests for the FastAPI Device REST API.
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       http://127.0.0.1:8000

*** Test Cases ***
T2-01 Request All Devices
    [Documentation]    Verify HTTP 200 and exactly 2 devices.
    ${response}=    GET    ${BASE_URL}/devices
    Should Be Equal As Integers    ${response.status_code}    200
    ${devices}=    Set Variable    ${response.json()}
    Length Should Be    ${devices}    2

T2-02 Request Device PART1234
    [Documentation]    Verify PART1234 has status ACTIVE.
    ${response}=    GET    ${BASE_URL}/devices/PART1234
    Should Be Equal As Integers    ${response.status_code}    200
    ${device}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${device}    status    ACTIVE

T2-03 Request Unknown Device
    [Documentation]    Verify unknown device returns HTTP 404.
    ${response}=    GET    ${BASE_URL}/devices/UNKNOWN    expected_status=404
    Should Be Equal As Integers    ${response.status_code}    404
    ${error}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${error}    detail    Device not found
