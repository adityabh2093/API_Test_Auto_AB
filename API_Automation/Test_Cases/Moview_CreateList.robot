*** Settings ***
Resource     ../Utils/Global_Resources/common_api.resource
Resource     ../Utils/Global_Resources/config_Enviroment.robot
Resource     ../Resource/MovieListResource.resource
Resource    ../Resource/MovieListResourceAdv.resource

Documentation       This suite contains end to end flow of create List ,Update list,Add Item, Update Item,Remove Item,

Test Setup    Run Keyword If    "${AccessGeneratePerTestcase}"=="True"    Generate Common Access Token     ${apiReadAccessToken}

Default Tags        API_Automation
   
Suite Teardown    Delete List For Movie    ${access_token}      ${list_id}

*** Variables ***
${request_token}
${access_token}
${list_id}

*** Test Cases ***

    
Generate access token
    
    ${access_token}=    Generate Common Access Token     ${apiReadAccessToken}
    
Create New List
    
    ${list_id}=           MovieListResourceAdv.Create List For Movie           ${access_token}         CreateNewllistDemo.properties
    Set Suite Variable    ${list_id} 
    Log To Console      ListId=${list_id}       


