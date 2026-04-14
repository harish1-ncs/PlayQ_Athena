@MGMAthena
Feature: Automation script for MGM

  Background:

  @MGMAthena1 @PRIORITY:1
  Scenario Outline: Scenario TC_MGN_O1 - Create Membership Application,Search Referre - Membership Application and Verify all initial criteria's are met
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    # * Comm: Verifying the custom actions

    # Referrer Membership Application
    * Step Group: -Fill_Member_Information.sg- -Fill Member Information-
    * Comm: Write-Data-To-Cell -filePath: "test-data/MGM.xlsx" -sheetName: "Member Information" -rowId: "TC_MGM_01" -data: "NRIC:'#{var.NRIC}'"
    * Step Group: -Add_Campaign_Code_NTUC.sg- -Add Campaign Code for NTUC-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup: -Submit_Application.sg- -Submit Application-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup:-GetExchangeID.sg- -Get Exchange ID-
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -text: "Membership Management" -options: ""


    # Referee Membership Application
    #* D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
    * Step Group: -Fill_Member_Information.sg- -Fill Member Information-
    * Step Group: -Add_Campaign_Code_NTUC.sg- -Add Campaign Code for NTUC-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup: -Input_Search_Referrer.sg- -Input Search Referrer-
    * D365CRM: Click top menu button -field: "Save" -options: ""
    * StepGroup: -Submit_Application.sg- -Submit Application-
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -text: "Membership Management" -options: ""

    # Get Exchange ID from API 

    # Run batch job
    * StepGroup: -Run_MGM_Batch_Job.sg- -Run MGM Batch Job-

    # Switch back to athena
    * StepGroup: -Switch_back_to_Athena.sg- -Switch Back to Athena-
    
    # MGM Details
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
    * StepGroup: -MGM_Details.sg- -MGM Details-
    * StepGroup: -Referee_Verification.sg- -Referee Verification-
  


    Examples: { "dataFile": "test-data/MGM.xlsx","filter": "_ID===\"TC_MGM_01\" && _STATUS===true" }



@MGMAthena1 @PRIORITY:1
  Scenario Outline: Scenario TC_MGN_O1 - Create Membership Application,Search Referre - Membership Application and Verify all initial criteria's are met
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    # * Comm: Verifying the custom actions

    # Referrer Membership Application
    * Step Group: -Fill_Member_Information.sg- -Fill Member Information-
    * Step Group: -Add_Campaign_Code_NTUC.sg- -Add Campaign Code for NTUC-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup: -Submit_Application.sg- -Submit Application-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup:-GetExchangeID.sg- -Get Exchange ID-
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -text: "Membership Management" -options: ""


    # Referee Membership Application
    #* D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
    * Step Group: -Fill_Member_Information.sg- -Fill Member Information-
    * Step Group: -Add_Campaign_Code_NTUC.sg- -Add Campaign Code for NTUC-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup: -Input_Search_Referrer.sg- -Input Search Referrer-
    * D365CRM: Click top menu button -field: "Save" -options: ""
    * StepGroup: -Submit_Application.sg- -Submit Application-
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -text: "Membership Management" -options: ""
    

    # Get Exchange ID from API 

    # Run batch job
    * StepGroup: -Run_MGM_Batch_Job.sg- -Run MGM Batch Job-

    # Switch back to athena
    * StepGroup: -Switch_back_to_Athena.sg- -Switch Back to Athena-
    
    # MGM Details
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
    * StepGroup: -MGM_Details.sg- -MGM Details-
    * StepGroup: -Referee_Verification.sg- -Referee Verification-
  


    Examples: { "dataFile": "test-data/MGM.xlsx","filter": "_ID===\"TC_MGM_02\" && _STATUS===true" }




 @MGMAthena3 @PRIORITY:3
  Scenario Outline: Scenario TC_MGN_O1 - Create Membership Application,Search Referre - Membership Application and Verify all initial criteria's are met with API
    * Comm: Store -value: "#{faker.custom.nric.generate({ prefix: 'S', yearOfBirth: 1985 })}" in -variable: "var.NRIC" -options: ""
    * Comm: Store -value: "#{faker.custom.person.fullName()}" in -variable: "var.NRIC.Name" -options: ""
    * Comm: Store -value: "#{faker.custom.nric.generate({ prefix: 'S', yearOfBirth: 1995 })}" in -variable: "var.NRIC_1" -options: ""
    * Comm: Store -value: "#{faker.custom.person.fullName()}" in -variable: "var.NRIC.Name_1" -options: ""
    * Comm: Store -value: "#{faker.custom.nric.getYear('#{var.NRIC}')}" in -variable: "var.NRIC.Year" -options: ""
    * Comm: Store -value: "#{faker.custom.nric.getYear('#{var.NRIC_1}')}" in -variable: "var.NRIC_1.Year" -options: ""
    * Comm: Generate first day of the current month in -format: "DD/MM/YYYY" into -variable "var.FirstDayCurrentMonth"
    * Comm: Generate last day of the current month in -format: "DD/MM/YYYY" into -variable "var.LastDayCurrentMonth"
    
  
    #* Api: Call api -action: "createMembership1" -config: "createNewMembership1" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""
    * Api: Call api -action: "changeMembership" -config: "createNewMembership" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""
    * Api: Call api -action: "createMembership" -config: "getMemberDetails" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""
    * Api: Store last response JSON paths to variables -paths: "$.getmemberdetailsResult[0].ExchangeId" -vars: "var.ExchangeID"
    * Api: Call api -action: "createMembership" -config: "createNewMembership1" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""
    # getMemberDetails

    * Api: Call api -action: "createMembership" -config: "getMemberDetails" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""

    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Memberships" -options: ""
    * D365CRM: Input text -fieldName: "SearchBoxWithTypeAhead-input" -text: "#{var.NRIC}" -options: ""
    * Web: Press Enter -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    
    * StepGroup: -Input_Search_Referrer.sg- -Input Search Referrer-
    * D365CRM: Click top menu button -field: "Save" -options: ""

    


    Examples: { "dataFile": "test-data/MGM.xlsx","filter": "_ID===\"TC_MGM_03\" && _STATUS===true" }




@MGMAthena4 @PRIORITY:4
  Scenario Outline: Scenario TC_MGN_O1 - Create Membership Application,Search Referre - Membership Application and Verify all initial criteria's are met with API
    * Comm: Store -value: "#{faker.custom.nric.generate({ prefix: 'S', yearOfBirth: 1985 })}" in -variable: "var.NRIC" -options: ""
    * Comm: Store -value: "#{faker.custom.person.fullName()}" in -variable: "var.NRIC.Name" -options: ""
    * Comm: Store -value: "#{faker.custom.nric.generate({ prefix: 'S', yearOfBirth: 1995 })}" in -variable: "var.NRIC_1" -options: ""
    * Comm: Store -value: "#{faker.custom.person.fullName()}" in -variable: "var.NRIC.Name_1" -options: ""
    * Comm: Store -value: "#{faker.custom.nric.getYear('#{var.NRIC}')}" in -variable: "var.NRIC.Year" -options: ""
    * Comm: Store -value: "#{faker.custom.nric.getYear('#{var.NRIC_1}')}" in -variable: "var.NRIC_1.Year" -options: ""
    * Comm: Generate first day of the current month in -format: "DD/MM/YYYY" into -variable "var.FirstDayCurrentMonth"
    * Comm: Generate last day of the current month in -format: "DD/MM/YYYY" into -variable "var.LastDayCurrentMonth"
    
  
    #* Api: Call api -action: "createMembership1" -config: "createNewMembership1" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""
    * Api: Call api -action: "changeMembership" -config: "createNewMembership" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""
    #* Api: Call api -action: "createMembership" -config: "getMemberDetails" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""
    * Api: Store last response JSON paths to variables -paths: "$.createnewmembershipoutputV2Result.ExchangeId" -vars: "var.ExchageID"
    * Api: Call api -action: "createMembership" -config: "getMemberDetails" -baseUrl: "#{env.api.athena.change.createMembership}" -options: ""s
    # getMemberDetails

    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Memberships" -options: ""
    * D365CRM: Input text -fieldName: "SearchBoxWithTypeAhead-input" -text: "#{var.NRIC}" -options: ""
    * Web: Press Enter -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    
    * StepGroup: -Input_Search_Referrer.sg- -Input Search Referrer-
    * D365CRM: Click top menu button -field: "Save" -options: ""

    


    Examples: { "dataFile": "test-data/MGM.xlsx","filter": "_ID===\"TC_MGM_04\" && _STATUS===true" }    





  @MGMAthena5 @PRIORITY:5
  Scenario Outline: Scenario TC_MGN_O1 - Create Membership Application,Search Referre - Membership Application and Verify all initial criteria's are met
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    # * Comm: Verifying the custom actions

    # Referrer Membership Application
    * Step Group: -Fill_Member_Information.sg- -Fill Member Information-
    * Step Group: -Add_Campaign_Code_NTUC.sg- -Add Campaign Code for NTUC-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup: -Submit_Application.sg- -Submit Application-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup:-GetExchangeID.sg- -Get Exchange ID-
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -text: "Membership Management" -options: ""


    # Referee Membership Application
    #* D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
    * Step Group: -Fill_Member_Information.sg- -Fill Member Information-
    * Step Group: -Add_Campaign_Code_NTUC.sg- -Add Campaign Code for NTUC-
    * Comm: Wait for milliseconds -seconds: "2000"
    * StepGroup: -Input_Search_Referrer.sg- -Input Search Referrer-
    * D365CRM: Click top menu button -field: "Save" -options: ""
    * StepGroup: -Submit_Application.sg- -Submit Application-
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -text: "Membership Management" -options: ""

    # Get Exchange ID from API 

    # Run batch job
    * StepGroup: -Run_MGM_Batch_Job.sg- -Run MGM Batch Job-

    # Switch back to athena
    * StepGroup: -Switch_back_to_Athena.sg- -Switch Back to Athena-
    
    # MGM Details
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
    * StepGroup: -MGM_Details.sg- -MGM Details-
    * StepGroup: -Referee_Verification.sg- -Referee Verification-
  


    Examples: { "dataFile": "test-data/MGM.xlsx","filter": "_ID===\"TC_MGM_04\" && _STATUS===true" }    





