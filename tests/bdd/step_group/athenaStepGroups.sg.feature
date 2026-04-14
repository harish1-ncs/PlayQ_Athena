@StepGroup
Feature: Common Step Groups for Athena
 
  @StepGroup:Fill_Member_Information.sg
  Scenario: Fill Member Information
    * Comm: Store -value: "#{faker.custom.nric.generate({ prefix: 'S', yearOfBirth: 1985 })}" in -variable: "var.NRIC" -options: ""
    * Comm: Store -value: "#{faker.custom.person.fullName()}" in -variable: "var.NRIC.Name" -options: ""
    * Comm: Store -value: "#{faker.custom.nric.getYear('#{var.NRIC}')}" in -variable: "var.NRIC.Year" -options: ""
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
    * Comm: Wait for milliseconds -seconds: "5000"
    * D365CRM: Click top menu button -field: "New" -options: ""
    * D365CRM: Wait and verify header -text: "New Membership Application" -options: "{partialMatch: true}"
    # =========================
    # Member Details
    # =========================
    * D365CRM: Input text -fieldName: "NRIC/FIN" -text: "#{var.NRIC}" -options: ""
    * D365CRM: Input text -fieldName: "Full Name (as per NRIC)" -text: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Input date into field -field: "Date of Birth" -date: "18/6/#{var.NRIC.Year}" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    # * D365CRM: Input text -fieldName: "Person" -text: "<Person>" -options: ""
    # * D365CRM: Input text -fieldName: "Membership" -text: "<Membership>" -options: ""
    # * D365CRM: Input text -fieldName: "Search Id" -text: "<Search_Id>" -options: ""
    # * D365CRM: Input text -fieldName: "Exchange ID" -text: "<Exchange_ID>" -options: ""
    # # Personal Particulars
    # * D365CRM: Input text -fieldName: "Name (to be printed on card)" -text: "<Name_to_be_printed_on_card>" -options: ""
    * D365CRM: Select dropdown -fieldName: "Race" -value: "<Race>" -options: ""
    * D365CRM: Select dropdown -fieldName: "Gender" -value: "<Gender>" -options: ""
    * D365CRM: Select dropdown -fieldName: "Marital Status" -value: "<Marital_Status>" -options: ""
    # * D365CRM: Input text -fieldName: "Salary Amount" -text: "<Salary_Amount>" -options: ""
    * D365CRM: Select dropdown -fieldName: "Education Level" -value: "<Education_Level>" -options: ""
    * D365CRM: Input lookup -field: "Nationality" -text: "<Nationality>" -options: ""
    * D365CRM: Select dropdown -fieldName: "Residential Status" -value: "<Residential_Status>" -options: ""
    # * D365CRM: Input text -fieldName: "Monthly Gross Salary" -text: "<Monthly_Gross_Salary>" -options: ""
    # =========================
    # Contact Details
    # =========================
    * D365CRM: Input text -fieldName: "Mobile Phone" -text: "<Mobile_Phone>" -options: ""
    # * D365CRM: Input text -fieldName: "Home Tel No." -text: "<Home_Tel_No>" -options: ""
    # * D365CRM: Input text -fieldName: "Office Tel No." -text: "<Office_Tel_No>" -options: ""
    # =========================
    # Occupation Details
    # =========================
    * D365CRM: Select dropdown -fieldName: "Employment Type" -value: "<Employment_Type>" -options: ""
    * D365CRM: Input text -fieldName: "Occupation" -text: "<Occupation>" -options: ""
    * D365CRM: Input lookup -field: "Occupation Group" -text: "<Occupation_Group>" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    * D365CRM: Input lookup -field: "Company" -text: "<Company>" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    # =========================
    # Address
    # =========================
    * D365CRM: Input text -fieldName: "Postal Code" -text: "<Postal_Code>" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Input text -fieldName: "Floor" -text: "<Floor>" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Input text -fieldName: "Unit" -text: "<Unit>" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Input text -fieldName: "Block No." -text: "<Block_No>" -options: ""
    * D365CRM: Input text -fieldName: "Building" -text: "<Building>" -options: ""
    * D365CRM: Input text -fieldName: "Street Name" -text: "<Street_Name>" -options: ""
    * D365CRM: Input text -fieldName: "Valid Address?" -text: "<Valid_Address>" -options: ""
 
  @StepGroup:Fill_Membership_Details.sg
  Scenario: Fill Membership Details
    * Comm: Generate first day of the last month in -format: "D/M/YYYY" into -variable "var.LastFirstDay"
    # =========================
    # Membership Info
    # =========================
    * D365CRM: Click tab -field: "Membership Details" -options: ""
    # * D365CRM: Input text -fieldName: "Payroll No." -text: "<Payroll_No>" -options: ""
    # * D365CRM: Input text -fieldName: "Employee Number" -text: "<Employee_Number>" -options: ""
    # * D365CRM: Input text -fieldName: "Member No." -text: "<Member_No>" -options: ""
    * D365CRM: Input lookup -field: "Union Code" -text: "<Union_Code>" -options: ""
    * D365CRM: Input lookup -field: "Branch Code" -text: "<Branch_Code>" -options: ""
    # * D365CRM: Input date into field -field: "Joined Union Date" -date: "#{var.LastFirstDay}" -options: ""
    # * D365CRM: Select dropdown -fieldName: "Allow ECard" -value: "<Allow_ECard>" -options: ""
    # * D365CRM: Input text -fieldName: "By Pass Hold List Reason" -text: "<Bypass_Hold_List_Reason>" -options: ""
    # =========================
    # Sign Up Details
    # =========================
    # * D365CRM: Input lookup -field: "Recruiter Code" -text: "<Recruiter_Code>" -options: ""
    # * D365CRM: Input lookup -field: "Campaign_Code" -text: "<Campaign_Code>" -options: ""
    # * D365CRM: Select dropdown -fieldName: "Application Source" -value: "<Application_Source>" -options: ""
    # * D365CRM: Input date into field -field: "Form Received Date" -date: "<Form_Received_Date>" -options: ""
    # * D365CRM: Input lookup -field: "Signup Reason" -text: "<Signup_Reason>" -options: ""
    # ========================
    # FairPrice Membership
    # =========================
    # * D365CRM: Select dropdown -fieldName: "Interested in FairPrice Membership Subscription?" -value: "<FairPrice_Subscription>" -options: ""
    # =========================
    # FairPrice Membership Bank Details
    # =========================
    # * D365CRM: Select dropdown -fieldName: "Same as GIRO Information" -value: "<Same_As_GIRO>" -options: ""
    # * D365CRM: Input text -fieldName: "Name(Fair Price Rebate)" -text: "<FairPrice_Rebate_Name>" -options: ""
    # * D365CRM: Input text -fieldName: "NRIC/FIN (Fair Price)" -text: "<FairPrice_NRIC>" -options: ""
    # * D365CRM: Input lookup -field: "Bank Name" -text: "<Bank_Name>" -options: ""
    # * D365CRM: Input lookup -field: "Bank Branch" -text: "<Bank_Branch>" -options: ""
    # * D365CRM: Input text -fieldName: "Account No." -text: "<Account_No>" -options: ""
    
 
  @StepGroup:Fill_Payment_Details.sg
  Scenario: Fill Payment Details
    * D365CRM: Click tab -field: "Payment Details" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Click top menu buttons -field: "More commands for Payment Collection" and then sub menu -field: "New Payment Collection" -options: ""
    * D365CRM: Wait and verify header -text: "New Payment Collection" -options: "{partialMatch:true}"
    * D365CRM: Select dropdown -fieldName: "Payment Type" -value: "<Payment_Type>" -options: ""
    * D365CRM: Click button -text: "Save" -options: ""
    * D365CRM: Wait for loader to disappear -field: "progressbar" -options: ""
    * D365CRM: Click top menu buttons -field: "Action" and then sub menu -field: "Payment received" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    * D365CRM: Click top menu button -field: "Go back" -options: ""
    * Comm: Wait for milliseconds -seconds: "4000"
    * D365CRM: Click top menu buttons -field: "More commands for Recurring Payment Instruction" and then sub menu -field: "New Recurring Payment Instruction" -options: ""
    * D365CRM: Wait and verify header -text: "New Recurring Payment Instruction" -options: "{partialMatch: true}"
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Select dropdown -fieldName: "Recurring Payment set up type" -value: "<Recurring_Payment_setup_type>" -options: ""
    * D365CRM: Input lookup -field: "Bank" -text: "<Bank>" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Input text -fieldName: "Bank Account Number" -text: "<Bank_Account_Number>" -options: ""
    * D365CRM: Input lookup -field: "Bank Branch" -text: "<Bank_Branch>" -options: ""
    * D365CRM: Click top menu button -field: "Save" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
 
  @StepGroup:Click_Proceed_Button_On_BackDate_Popup.sg
  Scenario: Click proceed button on backdate popup
    * D365CRM: Wait for loader to disappear -field: "progressbar" -options: ""
    * D365CRM: Click -field: "Proceed" button on back date popup -options: ""
    * D365CRM: Click popup button -field: "OK" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click popup button -field: "OK" -options: ""
 
  @StepGroup:Add_Campaign_Code_NTUC.sg
  Scenario: Add Campaign Code for NTUC
    * D365CRM: Click tab -field: "Membership Details" -options: ""
    * D365CRM: Input lookup -field: "Campaign Code" -text: "<Campaign_Code>" -options: ""
    * D365CRM: Click top menu button -field: "Save" -options: ""
    * D365CRM: Click top menu button -field: "Refresh" -options: ""
 
  @StepGroup:Submit_Application.sg
  Scenario: Submit Application
    * D365CRM: Click top menu buttons -field: "Actions More Commands. Actions" and then sub menu -field: "Submit" -options: ""
    * D365CRM: Click popup button -field: "OK" -options: ""
    * D365CRM: Click popup button -field: "OK" -options: ""


  @StepGroup:Membership_Details.sg
  Scenario: Membership Details
    * Comm: Generate first day of the current month in -format: "DD/MM/YYYY" into -variable "var.FirstDayCurrentMonth"
    # =========================
    # Membership Info
    # =========================
    # * D365CRM: Click tab -field: "Membership Details" -options: ""
    * D365CRM: Input lookup -field: "Union Code" -text: "<Union_Code>" -options: ""
    * D365CRM: Input lookup -field: "Branch Code" -text: "<Branch_Code>" -options: ""
    * D365CRM: Input date into field -field: "var.FirstDayCurrentMonth" -date: "#{var.LastFirstDay}" -options: ""
    * D365CRM: Click top menu button -field: "Save" -options: ""



  @StepGroup:Input_Search_Referrer.sg
  Scenario: Input Search Referrer
    * D365CRM: Click tab -field: "MGM and Membership Gift" -options: "" 
    #WebResource_referrerSearch
    #WebResource_ntuc_Referrersearchbutton
    #* Web: Switch to Frame -field: "WebResource_referrerSearch" -options: "{fieldType: 'iframe', pattern: 'd365crm'}"
    #* D365CRM: Click button -text: "openReferrerSearch()" -options: ""
    #* Web: Click button -field: "openReferrerSearch()" -options: "{fieldType: 'button', pattern: 'd365crm'}"
    * Custom: Switches to iframe: "WebResource_referrerSearch" and clicks a button: "Search Referrer" and then switches back to the main content
    #* Web: Switch to Frame -field: "FullPageWebResource" -options: "{fieldType: 'iframe', pattern: 'd365crm'}"
    * Custom: Switches to iframe: "FullPageWebResource" and input -field: "Enter Full Name or Exchange ID" -text: "#{var.ExchangeID}" and then switches back to the main content
    #* Web: Switch to Frame -field: "FullPageWebResource" -options: "{fieldType: 'iframe', pattern: 'd365crm'}"
    * Custom: Switches to iframe: "FullPageWebResource" and clicks a button: "Search" and then switches back to the main content
    #* Custom: Switches to iframe: "FullPageWebResource" and clicks a button: "#{var.ExchangeID}" and then switches back to the main content
    * Custom: Switches to iframe: "FullPageWebResource" and selects a radio button: "#{var.ExchangeID}" and then switches back to the main content
    * Custom: Switches to iframe: "FullPageWebResource" and clicks a button: "OK" and then switches back to the main content
    # * D365CRM: Click button -text: "searchButton" -options: ""
    # * D365CRM: Click button -text: "#{var.ExchangeID}" -options: ""
    # # * D365CRM: Click button -text: "searchButton" -options: ""
    # * D365CRM: Click button -text: "okButton" -options: ""


  @StepGroup:GetExchangeID.sg
  Scenario: Get Exchange ID
    * D365CRM: Click tab -field: "Member Information" -options: ""
    * Web: Get Value -field: "Exchange ID" -storeTo: "var.ExchangeID" -options: "{fieldType: 'input',pattern: 'd365crm'}"
    # //*[contains(@id,"headerControlsList")]/div[1]/div[1]/div
    #* D365CRM: Store header control list column value -field: "headerControlsList" to variable -variableName: "var.ExchangeID" -options: ""


  @StepGroup:Run_MGM_Batch_Job.sg
  Scenario: Run MGM Batch Job
    * D365CRM: Switch app from -field:"NTUC ATHENA" to -field:"Batch Jobs Administration" -options: ""
    * D365CRM: Input text -fieldName: "Ask about data in this table." -text: "<Batch_Job>" -options: ""
    * Web: Press Enter -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    * D365CRM: Click top menu button -field: "Trigger Job" -options: ""
    * Comm: Wait for milliseconds -seconds: "4000"
    # * D365CRM: Click button -text: "OK" -options: ""
    * Web: Click button -field: "OK" -options: "{pattern: 'd365crm'}"
    * Comm: Wait for milliseconds -seconds: "2000"


  @StepGroup:Switch_back_to_Athena.sg
  Scenario: Switch Back to Athena
    * D365CRM: Switch app from -field:"Batch Jobs Administration" to -field:"NTUC ATHENA" -options: ""
    * Comm: Wait for milliseconds -seconds: "4000"



  @StepGroup:MGM_Details.sg
  Scenario: MGM Details
    # //div[@aria-label='Steve Mark YUlrz']
    # * D365CRM: Click tab -field: "MGM and Membership Gift" -options: ""
    # * D365CRM: Click lookup record link -field: "#{var.name}" -options: ""
    # * Comm: Wait for milliseconds -seconds: "3000"
    # * D365CRM: Click tab -field: "Behavior, Needs & Interests" -options: ""
    # * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "MGM Details" -options: ""  
    * D365CRM: Click left menu -text: "MGM Details" -options: ""
    * D365CRM: Input text -fieldName: "Ask about data in this table." -text: "#{var.ExchangeID}" -options: ""
    * Web: Press Enter -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000" 
    * D365CRM: Verify header control list column value -field: "1" -variableName: "var.MGMStatus" -expectedValue: "In Progress" -options: ""
    #* D365CRM: Store header control list column value -field: "In Progress" to variable -variableName: "var.MGMStatus" -options: ""

    # //*[contains(@id,"headerControlsList")]/div/div[1]/div[contains(.,'In Progress')]
   
 

  @StepGroup:Referee_Verification.sg
  Scenario: Referee Verification
  * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Gift Details" -options: ""
  * D365CRM: Input text -fieldName: "SearchBoxWithTypeAhead-input" -text: "#{var.ExchangeID}" -options: ""
  * Web: Press Enter -options: ""
  * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
  * D365CRM: Store header control list column value -field: "1" to variable -variableName: "var.RequestID" -options: ""
  * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Memberships" -options: ""
  * D365CRM: Input text -fieldName: "SearchBoxWithTypeAhead-input" -text: "" -options: ""
  * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
  * D365CRM: Click tab -field: "MGM and Memberships" -options: ""
  # //div[@data-id='ntuc_referredbyrequestid.fieldControl-LookupResultsDropdown_ntuc_referredbyrequestid_selected_tag_text']
  * D365CRM: Verify input lookup field value -field: "ntuc_referredbyrequestid.fieldControl-LookupResultsDropdown_ntuc_referredbyrequestid_selected_tag_text" -value: "#{var.RequestID}" -options: ""
  * D365CRM: Verify input field value -field: "ntuc_referredbyrequestid.fieldControl-LookupResultsDropdown_ntuc_referredbyrequestid_selected_tag_text" -value: "#{var.RequestID}" -options: ""