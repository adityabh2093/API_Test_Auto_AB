*** Settings ***    
Resource     config_Enviroment.robot  



*** Keywords *** 
Request Request Token
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${apiReadAccessToken}
    ${headers}=        Set To Dictionary   ${headerParams}    
       
    ${request_body}    Set Variable    {"redirect_to":"${redirectUrl}"}
    ${json_data}       To Json    ${request_body}         
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Post Request        baseurl    auth/request_token    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}    200

    ${response}=       To Json      ${response.content}  
    ${request_token}=    Get Value From Json   ${response}    request_token 
    
    [Return]   ${request_token}
     
   
Verify User Access    [Arguments]         ${status}      ${Code} 
   Should Be Equal As Strings    ${status}    ${Code}  
 
Approve Access Token    [Arguments]         ${request_token} 
    
    ${headerParams}=   Create Dictionary    Content-Type=application/x-www-form-urlencoded        cookie=tmdb.prefs=%7B%22adult%22%3Afalse%2C%22i18n_fallback_language%22%3A%22en-US%22%2C%22locale%22%3A%22en-US%22%2C%22country_code%22%3A%22IN%22%2C%22timezone%22%3A%22Asia%2FCalcutta%22%7D; _ga=GA1.2.413858660.1618075102; _gid=GA1.2.634143328.1618075102; _dc_gtm_UA-2087971-10=1; tmdb.session=AZk5Sk_RUJzuN-IDnW36TF3o1PAxR8eOV2J0LvPJKCSGZ2EwMSOMS-24u-kBO3mb8opO83o4YAOWj57szLUYAcUxMMmkm8P7TQkrEeI8rirk2cNo0kuipimUjH7ZVhRi6nSenT8rBJvH1JRPr4LeQsKcE1qNrK8t60j3cgucL1BrATtSMbqqbBMFT2kGxBPnMi7lamaXE6C1l3KSPPe_8sIvMIQh_W_sU_JRZRS4LfaBIi4UmsmKJ9HkVDowsaKkgGEaMlE7dOPgTtgKyJMVS-hCjRckMGVHhQ0NAAU2RCt7xZe4tM8moiNc3f4Uk0SJTf-dJX2K52uy74CUMaF8H6gnrQmhtH_lLbOimCbbCznbKbcnKKxbBeV1ziy_s7EccmPJW_YLy5PG1NEUBwfu0aBu4mrP8c25YKRvTgboAsRKzoypIuOO-40UhRqwxzinB-_OGLtRO0jiuOX3pS06wj_WKmXvwpvELNhdrvyNmJ76ejJPXU0zeSHtvNKTt4SKLDCXMKwgsyC2vBYhTmSlzXk6cKXhgUCoVgYlK0eyu5p5-I9EKTB9f5VDXXN-33W05E6c6jgdJJ9lg_DnXgQjq5FMBuTxX4HnGoIdcSvichHhFhnMXAE7ANImB9drsR6bRSVWMbAJ0IiulP_lmQBpkCyYnTwFZUDBdqnGM-0D7_KT3j2XgZPYDVwCsb9iDwBaRXOyYRMlyQRwHECqb0gCtyoAZoGUsxcn6SY9inUByDLEKSKdvHnHOKKdhFlXmBPkmBIjiyerzV5kIJdqhx3RWe07F8_v731P_HADUv7bW7yNOYQZ0u5LGDuWlzPwyUeD6A%3D%3D
    ${headers}=        Set To Dictionary   ${headerParams}    
       
    ${requestBody}=   Create Dictionary    request_token=${request_token}[0]   submit=Approve 
    ${requestBody}=   Set To Dictionary   ${requestBody} 
     
    Create Session     baseurl    ${approveReuestBaseUrl}
    ${response}=       Post Request        baseurl    auth/access/approve   data=${requestBody}      headers=${headers}    
    
    Verify User Access     ${response.status_code}            200
  
Request Access Token    [Arguments]         ${request_token} 
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${apiReadAccessToken}
    ${headers}=        Set To Dictionary   ${headerParams} 
    
    ${request_body}    Set Variable    {"request_token":"${request_token}[0]"}
    ${json_data}       To Json    ${request_body}    
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Post Request        baseurl    auth/access_token    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}            200

    ${response}=       To Json      ${response.content}  
    ${access_token}=    Get Value From Json   ${response}    access_token 
    
    [Return]   ${access_token}
    


Generate Common Access Token 
    [Arguments]         ${request_token}
    
    ${request_token}=    Request Request Token
    Log To Console  requestTokenGenerated!!!
    Set Suite Variable    ${request_token}            
    Log To Console    requestToken=${request_token}
    Log To Console    Approve Request Token
    Approve Access Token    ${request_token}  
    ${access_token}=    Request Access Token    ${request_token}
    Log To Console  accesstoken=${access_token}
    Set Global Variable    ${access_token} 

  [Return]    ${access_token}
