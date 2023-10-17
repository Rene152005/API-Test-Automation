*** Settings ***
Library                     RequestsLibrary


*** Variables ***
${BASE_URL}                 https://catfact.ninja
&{BREEDS_PARAMS}            limit=75
&{FACT_PARAMS}              max_length=200
&{FACTS_PARAMS}             max_length=200          limit=10
${SUCCESS}                  200


*** Test Cases ***
Check for all cat breeds
    [Documentation]         This validates if /breeds endpoint is working properly.
    ${response}             GET    url=${BASE_URL}/breeds    params=&{BREEDS_PARAMS}
    Status Should Be        ${SUCCESS}
    Log to Console          Response code: ${response.status_code}
    IF    ${response.ok} == False
          Log to Console    Something went wrong! The Response code was: ${response.status_code}
    END
    ${current_page}         Set Variable       ${response.json()['current_page']}
    Log to console          The current page in the body is: ${current_page}  
    ${data}                 Set Variable       ${response.json()['data']}
    Log To Console          The contents in the body: ${data}
    

#Test: "/fact"
#    [Documentation]        This validates if '/fact' endpoint is working properly.
#    ${response}            GET    url=${BASE_URL}/fact    params=&{FACT_PARAMS}
#    Status Should Be       200
#    IF    ${response.ok} == False
#            Fail    Response code: ${response.status_code}
#    END
#    ${fact}          Set Variable     ${response.json()['fact']}
#    Log To Console   Cat Fact: ${fact}
#
#Test: "/facts"
#    [Documentation]        This validates if '/facts' endpoint is working properly.
#    ${response}            GET    url=${BASE_URL}/facts    params=&{FACTS_PARAMS}
#    # Status Should Be       200
#    IF    ${response.ok} == False
#            Fail    Response code: ${response.status_code}
#    END
#    @{data}          Set Variable     ${response.json()['data']}
#    ${numFacts}      Get Length       ${data}
#    Log To Console   Retrieved Facts: ${numFacts}
#    FOR    ${record}     IN    @{data}
#        Log To Console   ${record['fact']}
#    END
#    