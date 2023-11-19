*** Settings ***
Documentation       Robot to solve the first challenge at rpachallenge.com,
...                 which consists of filling a form that randomly rearranges
...                 itself for ten times, with data taken from a provided
...                 Microsoft Excel file.

Library             RPA.Browser.Playwright
Library             RPA.Excel.Files
Library             RPA.HTTP
Library             RPA.FileSystem


*** Variables ***
${TARGET_FILE}              ${CURDIR}${/}downloads${/}customers.xlsx
${URL_RPACHALLENGE}         http://rpachallenge.com/
${PATH_CHALLENGE_FILE}      http://rpachallenge.com/assets/downloadFiles/challenge.xlsx


*** Tasks ***
Add Customers From List
    Get Excel File with Customer Info
    Open RPA Challenge Website
    Fill the forms
    Collect the results
    [Teardown]    Teardown


*** Keywords ***
Get Excel File with Customer Info
    RPA.HTTP.Download
    ...    ${PATH_CHALLENGE_FILE}
    ...    target_file=${TARGET_FILE}
    ...    overwrite=True

Open RPA Challenge Website
    Open Browser
    New Page    ${URL_RPACHALLENGE}
    Click    button

Fill the forms
    ${people}=    Get the list of people from the Excel file
    FOR    ${person}    IN    @{people}
        Fill and submit the form    ${person}
    END

Get the list of people from the Excel file
    Open Workbook    ${TARGET_FILE}
    ${table}=    Read Worksheet As Table    header=True
    Close Workbook
    RETURN    ${table}

Fill and submit the form
    [Arguments]    ${person}
    Fill Text    //input[@ng-reflect-name="labelFirstName"]    ${person}[First Name]
    Fill Text    //input[@ng-reflect-name="labelLastName"]    ${person}[Last Name]
    Fill Text    //input[@ng-reflect-name="labelCompanyName"]    ${person}[Company Name]
    Fill Text    //input[@ng-reflect-name="labelRole"]    ${person}[Role in Company]
    Fill Text    //input[@ng-reflect-name="labelAddress"]    ${person}[Address]
    Fill Text    //input[@ng-reflect-name="labelEmail"]    ${person}[Email]
    Fill Text    //input[@ng-reflect-name="labelPhone"]    ${person}[Phone Number]
    Click    input[type=submit]

Collect the results
    Take Screenshot    ${CURDIR}${/}receipt${/}screenshot-{index}
    Close Browser

Teardown
    Close Browser
    Remove File    ${TARGET_FILE}
