*** Settings ***    
Resource        ../Utils/Global_Resources/config_Enviroment.robot 
Resource        ../Utils/Global_Resources/common_api.resource

*** Keywords ***

Create List For Movie   [Arguments]         ${access_token}         ${FileName}
    [Documentation]        This method creating list for movies 
    
    ${TestData}=         get config properties without Global         ${FileName}
    ${json_data}=        Update json                     ${TestData}       CreateNewList.json     
    ${headerParams}=     Create Dictionary               Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=          Set To Dictionary               ${headerParams}
    ${String}=           Generate Random String          3 
    ${Listname}=         Set Variable                    ${TestData}[name]${String}
    
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Post Request        baseurl    list    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}            201

    ${response}=         To Json               ${response.content}  
    ${list_id}=          Get Value From Json   ${response}                id 
    ${StatusMsg}=        Get Value From Json   ${response}                status_message
    ${StatusMsg}=        Convert to string     ${StatusMsg}
    Should Be Equal       ${StatusMsg}         ['The item/record was created successfully.']
    
    [Return]   ${list_id}
     


Update json      [Arguments]            ${TestData}        ${JsonFilename}
    [Documentation]        This method updating The json as per properties file 
        
    ${Mapping}          Get File   ${CURDIR}/Json/${JsonFilename}
    ${json_data}        To Json    ${Mapping}  
     
    FOR    ${element}    IN    @{TestData.keys()}
        
        ${json}=    Update Value To Json    ${json_data}    ${element}   ${TestData}[${element}]
        
    END
        
        
    [Return]         ${json}
