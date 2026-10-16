
*** Settings ***
Documentation     Robot Framework tests for the JSONPlaceholder Users REST API.
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       https://jsonplaceholder.typicode.com

*** Test Cases ***
T1-01 Request All Users
    [Documentation]    Verify that the users API returns HTTP 200.
    ${response}=    GET    ${BASE_URL}/users    expected_status=anything
    Should Be Equal As Integers    ${response.status_code}    200

T1-02 Number Of Users
    [Documentation]    Verify that exactly 10 users are returned.
    ${response}=    GET    ${BASE_URL}/users
    ${users}=    Set Variable    ${response.json()}
    Length Should Be    ${users}    10

T1-03 Mandatory Fields
    [Documentation]    Verify every user contains id, name and email.
    ${response}=    GET    ${BASE_URL}/users
    ${users}=    Set Variable    ${response.json()}

    FOR    ${user}    IN    @{users}
        Dictionary Should Contain Key    ${user}    id
        Dictionary Should Contain Key    ${user}    name
        Dictionary Should Contain Key    ${user}    email
    END

T1-04 Company Check
    [Documentation]    Verify at least one user belongs to Romaguera-Crona.
    ${response}=    GET    ${BASE_URL}/users
    ${users}=    Set Variable    ${response.json()}
    ${found}=    Set Variable    ${False}

    FOR    ${user}    IN    @{users}
        ${company}=    Get From Dictionary    ${user}    company
        ${name}=    Get From Dictionary    ${company}    name

        IF    $name == "Romaguera-Crona"
            ${found}=    Set Variable    ${True}
            BREAK
        END
    END

    Should Be True    ${found}
