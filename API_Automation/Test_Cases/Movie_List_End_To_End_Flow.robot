*** Settings ***
Resource     ../Utils/Global_Resources/common_api.resource
Resource     ../Utils/Global_Resources/config_Enviroment.robot
Resource     ../Resource/MovieListResource.resource

Documentation       This suite contains end to end flow of create List ,Update list,Add Item, Update Item,Remove Item,

##If you need to run perticular case you need to Set AccessGeneratePerTestcase==True And need to provide list_id
Test Setup    Run Keyword If    "${AccessGeneratePerTestcase}"=="True"    Generate Common Access Token     ${apiReadAccessToken}

Default Tags        API_Automation
   
*** Variables ***
${request_token}
${access_token}
${list_id}

*** Test Cases ***

    
Generate access token
    
    ${access_token}=    Generate Common Access Token     ${apiReadAccessToken}
    
Create New List
    Log To Console  accesstoken=${access_token}
    ${list_id}=     Create List For Movie       ${access_token} 
    Set Suite Variable    ${list_id} 
    Log To Console      ListId=${list_id}       


update New List
    Log To Console  accesstoken=${access_token}
    Update List For Movie       ${access_token}         ${list_id}   
    
Add item In List For Movie
       
    Add item In List For Movie         ${access_token}         ${list_id}


Update item In List For Movie
       
   Update item In List For Movie      ${access_token}         ${list_id}


Remove item In List For Movie
       
   Remove item In List For Movie      ${access_token}         ${list_id}

Check Item Status For Movie      
     ${status_message}=    Check item Status For Movie      ${access_token}         ${list_id}      550     movie   
     Log To Console   ${status_message}       

Clear item In List For Movie
    Clear item In List For Movie        ${access_token}         ${list_id}
  

Deleted New List
    Log To Console  requesttoken=${access_token}
    Delete List For Movie    ${access_token}      ${list_id} 
               
   


    
    