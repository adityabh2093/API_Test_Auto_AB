*** Settings ***    
Resource        ../Utils/Global_Resources/config_Enviroment.robot 
Resource        ../Utils/Global_Resources/common_api.resource

*** Keywords ***


Create List For Movie   [Arguments]         ${access_token}         ${FileName}        ${ResJsonFile}
    [Documentation]        This method creating list for movies     
    
    ${TestData}=         get config properties without Global         ${FileName}        ${OS}
    ${json_data}=        Update json                     ${TestData}       CreateNewList.json     
    ${headerParams}=     Create Dictionary               Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=          Set To Dictionary               ${headerParams}
    ${String}=           Generate Random String          3 
    ${Listname}=         Set Variable                    ${TestData}[name]${String}
    
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Post Request        baseurl    list    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}            201

    ${response}=         Convert String to JSON                ${response.content}  
    ${list_id}=          Get Value From Json   ${response}                id 
    Validate Responce Json      ${response}            ${ResJsonFile}
    
    [Return]   ${list_id}
     

Delete List For Movie   [Arguments]         ${access_token}         ${list_id}
    [Documentation]    This method Deleting created movie list
    
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=        Set To Dictionary   ${headerParams} 
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Delete Request        baseurl    list/${list_id}[0]    headers=${headers}     
    
    Verify User Access     ${response.status_code}            200

    ${response}=         Convert String to JSON       ${response.content}  
    ${access_token}=    Get Value From Json   ${response}    access_token 
    
    [Return]   ${access_token}
     


Update List For Movie   [Arguments]         ${access_token}     ${list_id}
    [Documentation]    This method Updating created movie list
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=        Set To Dictionary   ${headerParams} 
    
    ${request_body}    Set Variable   {"description": "ThisIstest1233"}
    ${json_data}       Convert String to JSON     ${request_body}    
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Put Request        baseurl    list/${list_id}[0]    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}            201

    ${response}=       Convert String to JSON       ${response.content}  
    ${list_id}=        Get Value From Json   ${response}    id 
    
    [Return]   ${list_id}



Add item In List For Movie   [Arguments]         ${access_token}     ${list_id}
    [Documentation]    This method Add item in created movie list
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=        Set To Dictionary   ${headerParams} 
    
    ${request_body}    Set Variable      {"items":[{"media_type":"movie","media_id":550},{"media_type":"movie","media_id":244786},{"media_type":"tv","media_id":1396}]}
    ${json_data}       Convert String to JSON     ${request_body}    
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Post Request        baseurl    list/${list_id}[0]/items    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}            200

    ${response}=       Convert String to JSON       ${response.content}  
    ${list_id}=        Get Value From Json   ${response}    id 
    
    [Return]   ${list_id}




Clear item In List For Movie   [Arguments]         ${access_token}     ${list_id}
    [Documentation]    This method Clear created movie list
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=        Set To Dictionary   ${headerParams} 
    
    Create Session     baseurl    ${baseUrl}
    ${response}=     Get Request       baseurl    list/${list_id}[0]/clear    headers=${headers}     
    
    Verify User Access     ${response.status_code}            200
    ${response}=       Convert String to JSON                ${response.content}  
    ${list_id}=        Get Value From Json   ${response}    id 
    
    [Return]   ${list_id}
    
    
Update item In List For Movie   [Arguments]         ${access_token}     ${list_id}
    [Documentation]    This method update Item in created movie list
    
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=        Set To Dictionary   ${headerParams} 
    
    ${request_body}    Set Variable     {"items":[{"media_type":"movie","media_id":194662,"comment":"Amazing movie34!"},{"media_type":"movie","media_id":76203,"comment":"Wow."}]}
    ${json_data}       Convert String to JSON     ${request_body}    
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Post Request        baseurl    list/${list_id}[0]/items    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}            200

    ${response}=       Convert String to JSON                ${response.content}  
    ${list_id}=        Get Value From Json   ${response}    id 
    
    [Return]   ${list_id}



Remove item In List For Movie   [Arguments]         ${access_token}     ${list_id}
    [Documentation]    This method Remove Item in created movie list
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=        Set To Dictionary   ${headerParams} 
    
    ${request_body}    Set Variable     {"items":[{"media_type":"movie","media_id":194662,"comment":"Amazing movie34!"},{"media_type":"movie","media_id":76203,"comment":"Wow."}]}
    ${request_body}=    Convert String to JSON    ${request_body}
    #${json_data}       Convert String to JSON     ${request_body}    
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Delete Request       baseurl    list/${list_id}[0]/items    headers=${headers}     data=${request_body}
    
    Verify User Access     ${response.status_code}            200

    ${response}=       Convert String to JSON              ${response.content}  
    ${list_id}=        Get Value From Json   ${response}    id 
    
    [Return]   ${list_id}

Check item Status For Movie      [Arguments]       ${access_token}         ${list_id}     ${media_id}      ${media_type}
    [Documentation]    This method Check item Status in created movie list 
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}[0]
    ${headers}=        Set To Dictionary   ${headerParams} 
       
    Create Session    baseurl    ${baseUrl}   
    ${response}=      Get Request    baseurl    list/${list_id}[0]/item_status?media_id=${media_id}&media_type=${media_type}    headers=${headers}          
         
    Verify User Access     ${response.status_code}            200

    ${response}=           Convert String to JSON                ${response.content}  
    ${status_message}=     Get Value From Json   ${response}        status_message
    
    [Return]   ${status_message} 
    


Get List Details     [Arguments]       ${access_token}         ${list_id}        ${ResJsonFile}       ${WrongID}=None         
    [Documentation]    This method Check item Status in created movie list 
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${access_token}
    ${headers}=        Set To Dictionary   ${headerParams} 
       
    Create Session    baseurl    ${baseUrl}   
    ${response}=      Get Request    baseurl    list/${list_id}?page=1&api_key=${apiKey}            headers=${headers}
    
    Run Keyword If   "${WrongID}"=="True"      Verify User Access     ${response.status_code}           404  
    Run Keyword If   "${WrongID}"=="None"      Verify User Access     ${response.status_code}             200
    ${response}=           Convert String to JSON                ${response.content}      
    
    Return From Keyword If    "${WrongID}"=="True"        
    ${ID}=     Get Value From Json   ${response}        id
    ${ID}=    Convert To String    ${ID}
    Should Be Equal    ${ID}    [${list_id}]     
    Validate Responce Json      ${response}            ${ResJsonFile}
    
    [Return]   


