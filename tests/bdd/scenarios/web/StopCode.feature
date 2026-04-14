@StopCodeAutomation
Feature: Automation script for Stop Code

  @SC01A @SC01A_TestData @PRIORITY:1
  Scenario Outline: Scenario SC01A - Create Membership, RPI and Transfer Case
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    * Step Group: -Fill_Member_Information.sg- -Fill Member Information-
    * Step Group: -Fill_Membership_Details.sg- -Fill Membership Details-
    * Comm: Wait for milliseconds -seconds: "2000"
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click button -text: "Save" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Wait for loader to disappear -field: "progressbar" -options: ""
    * D365CRM: Click top menu buttons -field: "Actions More Commands. Actions" and then sub menu -field: "Submit" -options: ""
    * Step Group: -Click_Proceed_Button_On_BackDate_Popup.sg- -Click proceed button on backdate popup-
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click lookup record link -field: "Membership" -options: ""
    * D365CRM: Wait and verify header -text: "#{var.NRIC.Name}" -options: "{partialMatch:true}"
    * Step Group: -Fill_Payment_Details.sg- -Fill Payment Details-
    * D365CRM: Logout from Dynamics -options: ""
# Login with Finanace User
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.finusername}" -password: "#{env.finpassword}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    * D365CRM: Click left menu -field: "Payment Collection" then sub menu -field: "Recurring Payment Instructions" -options: ""
    * D365CRM: Table input filter -field: "Filter by keyword" -text: "#{var.NRIC.Name}" -options: ""
    * Comm: Wait for milliseconds -seconds: "1000"
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Select dropdown -fieldName: "Payment Instruction Status" -value: "<Payment_Instruction_Status>" -options: ""
    * D365CRM: Click top menu button -field: "Save" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Logout from Dynamics -options: ""
# Again Login with normal user
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Click left menu -field: "Payment Collection" then sub menu -field: "Recurring Payment Instructions" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.NRIC.Name}" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Verify input field attribute value -field: "Payment Instruction Status" -variableName: "var.PaymentInstructionStatus" -expectedValue: "<Payment_Instruction_Status>" -options: ""
    * D365CRM: Click lookup record link -field: "Membership" -options: ""
    * Comm: Wait for milliseconds -seconds: "5000"
    * D365CRM: Click tab -field: "Cases/Request" -options: ""
    * D365CRM: Click button -text: "New Cases/Requests" -options: ""
    * D365CRM: Wait and verify header -text: "New Cases/Requests" -options: "{partialMatch: true}"
    * D365CRM: Select dropdown -fieldName: "Category" -value: "TRANSFER REQUEST" -options: ""
    * D365CRM: Input lookup -field: "Target Company" -text: "<Target_Company>" -options: ""
    * D365CRM: Select dropdown -fieldName: "Target Employment Type" -value: "<Target_Employment_Type>" -options: ""
    * D365CRM: Input lookup -field: "Target Union Code" -text: "<Target_Union_Code>" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    * D365CRM: Input lookup -field: "Target Branch Code" -text: "<Target_Branch_Code>" -options: ""
    * D365CRM: Input text -fieldName: "New Occupation" -text: "<New_Occupation>" -options: ""
    * D365CRM: Input lookup -field: "New Occupation Group, Lookup" -text: "<New_Occupation_Group>" -options: ""
    * D365CRM: Select dropdown -fieldName: "Target Payment Mode" -value: "<Target_Payment_Mode>" -options: ""
    * D365CRM: Click button -text: "Save (CTRL+S)" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Store header control list column value -field: "1" to variable -variableName: "var.CaseNumber" -options: ""
    * Comm: Wait for milliseconds -seconds: "6000"
    * D365CRM: Click top menu button -field: "Go back" -options: ""
    * Comm: Wait for milliseconds -seconds: "6000"
    * D365CRM: Click tab -field: "Membership Details" -options: ""
    * D365CRM: Wait and verify header -text: "Membership Listing" -options: ""
    * Web: Scroll to element -field: "Delayed Deduction Details" -options: "{pattern: 'd365crm',fieldType:'header'}"
    * D365CRM: Verify input field value -field: "Delayed Deduction" -value: "<Delayed_Deduction_Flag>" -options: ""
    * D365CRM: Verify input field value -field: "Delayed Deduction Type" -value: "<Delayed_Deduction_Type>" -options: ""
    * Comm: Write-Data-To-Cell -filePath: "test-data/ntuc.xlsx" -sheetName: "Member Information" -rowId: "SC01" -data: "NRIC:'#{var.NRIC}',Full_Name:'#{var.NRIC.Name}'"
    * Comm: Write-Data-To-Cell -filePath: "test-data/ntuc.xlsx" -sheetName: "CasesOrRequests" -rowId: "SC01" -data: "Case_Number:'#{var.CaseNumber}'"
    * D365CRM: Logout from Dynamics -options: ""

    Examples: { "dataFile": "test-data/ntuc.xlsx","filter": "_ID===\"SC01\" && _STATUS===true" }

  @SC01A @SC01A_RPI_Validation @PRIORITY:2
  Scenario Outline: Scenario SC01A - Validate Stop code when case status is Draft, In Progress, Approved & Completed
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Cases/Requests" -options: ""
    * D365CRM: Wait and verify header -text: "Case Interaction" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.CaseNumber}" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    * D365CRM: Wait and verify header -text: "TRANSFER REQUEST" -options: "{partialMatch: true}"
    * D365CRM: Verify header control list column value -field: "3" -variableName: "var.CaseStatus" -expectedValue: "Draft" -options: ""
    * D365CRM: Click left menu -text: "Membership Management" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    * D365CRM: Click left menu -field: "Payment Collection" then sub menu -field: "Recurring Payment Instructions" -options: ""
    * D365CRM: Wait and verify header -text: "Recurring Payment Instructions" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.NRIC.Name}" -options: ""
    * Comm: Wait for milliseconds -seconds: "1000"
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Wait and verify header -text: "#{var.NRIC.Name}" -options: "{partialMatch: true}"
    * D365CRM: Verify input lookup field value -field: "Stop Reason" -value: "" -options: ""
    * D365CRM: Click left menu -text: "Payment Collection" -options: ""
# SECTION 2 — Submit Case → Validate “In Progress”
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Cases/Requests" -options: ""
    * D365CRM: Wait and verify header -text: "Case Interaction" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.CaseNumber}" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    * D365CRM: Wait and verify header -text: "TRANSFER REQUEST" -options: "{partialMatch: true}"
    * D365CRM: Click top menu buttons -field: "Action" and then sub menu -field: "Submit" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Verify header control list column value -field: "3" -variableName: "var.CaseStatus" -expectedValue: "In Progress" -options: ""
    * D365CRM: Click left menu -text: "Membership Management" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -field: "Payment Collection" then sub menu -field: "Recurring Payment Instructions" -options: ""
    * D365CRM: Wait and verify header -text: "Recurring Payment Instructions" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.NRIC.Name}" -options: ""
    * Comm: Wait for milliseconds -seconds: "1000"
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Wait and verify header -text: "#{var.NRIC.Name}" -options: "{partialMatch: true}"
    * D365CRM: Verify input lookup field value -field: "Stop Reason" -value: "" -options: ""
    * D365CRM: Click left menu -text: "Payment Collection" -options: ""
# SECTION 3 — Approve Case → Validate Approved Status
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Cases/Requests" -options: ""
    * D365CRM: Wait and verify header -text: "Case Interaction" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.CaseNumber}" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    * D365CRM: Wait and verify header -text: "TRANSFER REQUEST" -options: "{partialMatch: true}"
    * D365CRM: Click top menu buttons -field: "Action" and then sub menu -field: "Approve" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Verify header control list column value -field: "3" -variableName: "var.CaseStatus" -expectedValue: "Approved" -options: ""
    * D365CRM: Click left menu -text: "Membership Management" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * D365CRM: Click left menu -field: "Payment Collection" then sub menu -field: "Recurring Payment Instructions" -options: ""
    * D365CRM: Wait and verify header -text: "Recurring Payment Instructions" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.NRIC.Name}" -options: ""
    * Comm: Wait for milliseconds -seconds: "1000"
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Wait and verify header -text: "#{var.NRIC.Name}" -options: "{partialMatch: true}"
    * D365CRM: Verify input lookup field value -field: "Stop Reason" -value: "<Stop_Reason>" -options: ""
    * D365CRM: Click left menu -text: "Payment Collection" -options: ""
# SECTION 4 — Validate Approved Case Fields
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Cases/Requests" -options: ""
    * D365CRM: Wait and verify header -text: "Case Interaction" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.CaseNumber}" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    * D365CRM: Wait and verify header -text: "TRANSFER REQUEST" -options: "{partialMatch: true}"
    * D365CRM: Verify header control list column value -field: "3" -variableName: "var.CaseStatus" -expectedValue: "Approved" -options: ""
    * Comm: Generate first day of the next month in -format: "D/M/YYYY" into -variable "var.FirstNextMonth"
    * D365CRM: Verify input field value -field: "Effective Transfer Date" -value: "#{var.FirstNextMonth}" -options: ""
    * D365CRM: Verify input field value -field: "System Transfer Date" -value: "#{var.FirstNextMonth}" -options: ""
    * D365CRM: Verify input field value -field: "Notice Period" -value: "<Notice_Period>" -options: ""
    * Comm: Generate date from current date by adding business -days: "1" in -format: "D/M/YYYY" into -variable "var.1BusinessDay"
    * D365CRM: Verify input date -field: "Last Date to Reject Transfer" -value: "#{var.1BusinessDay}" -options: ""
    * Web: Scroll to element -field: "SOURCE" -options: "{pattern: 'd365crm',fieldType:'header'}"
    * D365CRM: Verify input field attribute value -field: "Type" -variableName: "var.type" -expectedValue: "<Type>" -options: ""
    * D365CRM: Verify input field value -field: "Proposed Date Join Union" -value: "#{var.FirstNextMonth}" -options: ""
    * Comm: Generate first day of the last month in -format: "D/M/YYYY" into -variable "var.LastFirstDay"
    * D365CRM: Verify input field value -field: "Union Join Date" -value: "#{var.LastFirstDay}" -options: ""
    * D365CRM: Verify input field attribute value -field: "Target Payment Mode" -variableName: "var.TargetPaymentMode" -expectedValue: "<Target_Payment_Mode>" -options: ""
    * Comm: Generate last day of the current month in -format: "D/M/YYYY" into -variable "var.lastDayOfCurrentMonth"
    * D365CRM: Verify input field value -field: "Last Paid Month" -value: "#{var.lastDayOfCurrentMonth}" -options: ""
    * D365CRM: Click left menu -text: "Membership Management" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    * D365CRM: Logout from Dynamics -options: ""
# SECTION 5 — Execute API + Trigger Batch Job
    # * Store -value: "#{var.CaseNumber}" in -variable: "var.caseNumber" -options: ""
    * Comm: Wait for milliseconds -seconds: "6000"
    * Api: Call api -action: "changeDateTransfer" -config: "changeDateTransferCase" -baseUrl: "#{env.api.athena.change.date.transfercase.baseUrl}" -options: ""
    * Comm: Wait for milliseconds -seconds: "2000"
    * Api: Assert api path value -path: "updateTransferCaseResult.message" -expected: "Case updated successfully." -options: ""
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    * Comm: Wait for milliseconds -seconds: "5000"
    * D365CRM: Switch app from -field:"NTUC ATHENA" to -field:"Batch Jobs Administration" -options: ""
    * D365CRM: Wait and verify header -text: "Active Master Batch Jobs" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" -options: ""
    * D365CRM: Click link with text -field: "D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" -options: ""
    * D365CRM: Wait and verify header -text: "D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" -options: "{partialMatch: true}"
    * D365CRM: Click top menu button -field: "Trigger Job" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * Comm: Wait for milliseconds -seconds: "3000"
    * Web: Click button -field: "OK" -options: "{pattern: 'd365crm'}"
    * D365CRM: Switch app from -field:"Batch Jobs Administration" to -field:"NTUC ATHENA" -options: ""
# SECTION 6 — Validate Completed Status
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Cases/Requests" -options: ""
    * D365CRM: Wait and verify header -text: "Case Interaction" -options: ""
    * D365CRM: Table input filter -field: "Ask about data in this table." -text: "#{var.CaseNumber}" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Double click table cell with row -row: "1" and column -column: "1" -options: ""
    * D365CRM: Wait and verify header -text: "TRANSFER REQUEST" -options: "{partialMatch: true}"
    * D365CRM: Verify header control list column value -field: "3" -variableName: "var.CaseStatus" -expectedValue: "Completed" -options: ""
    * D365CRM: Click left menu -text: "Membership Management" -options: ""
# SECTION 7 — Membership Validation (NEW → TRANSFERRED)
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Memberships" -options: ""
    * D365CRM: Wait and verify header -text: "Union Memberships" -options: ""
    * D365CRM: Click main system view -field:"Union Memberships" then sub system view -field:"All Memberships" -options: ""
    * D365CRM: Wait and verify header -text: "All Memberships" -options: ""
    * D365CRM: Table edit filter delete all and input new filters -filters: "['Membership Status','Equals','NEW'],['Full Name (as per NRIC)','Equals','#{var.NRIC.Name}']" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Wait and verify header -text: "#{var.NRIC.Name}" -options: "{partialMatch:true}"
    * D365CRM: Click tab -field: "Membership Details" -options: ""
    * Web: Scroll to element -field: "Delayed Deduction Details" -options: "{pattern: 'd365crm',fieldType:'header'}"
    * D365CRM: Verify input field value -field: "Delayed Deduction" -value: "<Delayed_Deduction_Flag>" -options: ""
    * D365CRM: Verify input field value -field: "Delayed Deduction Type" -value: "<Delayed_Deduction_Type>" -options: ""
    * D365CRM: Click left menu -text: "Membership Management" -options: ""
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Memberships" -options: ""
    * D365CRM: Wait and verify header -text: "Union Memberships" -options: ""
    * D365CRM: Click main system view -field:"Union Memberships" then sub system view -field:"All Memberships" -options: ""
    * D365CRM: Wait and verify header -text: "All Memberships" -options: ""
    * D365CRM: Table edit filter delete all and input new filters -filters: "['Membership Status','Equals','TRANSFERRED'],['Full Name (as per NRIC)','Equals','#{var.NRIC.Name}']" -options: ""
    * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Wait and verify header -text: "#{var.NRIC.Name}" -options: "{partialMatch:true}"
    * D365CRM: Click tab -field: "Membership Details" -options: ""
    * Web: Scroll to element -field: "Delayed Deduction Details" -options: "{pattern: 'd365crm',fieldType:'header'}"
    * D365CRM: Verify input field value -field: "Delayed Deduction" -value: "<Delayed_Deduction_Flag>" -options: ""
    * D365CRM: Verify input field value -field: "Delayed Deduction Type" -value: "<Delayed_Deduction_Type>" -options: ""
    * D365CRM: Click left menu -text: "Membership Management" -options: ""
# SECTION 8 — RPI Final Validation
    * D365CRM: Click left menu -field: "Payment Collection" then sub menu -field: "Recurring Payment Instructions" -options: ""
    * D365CRM: Table edit filter delete all and input new filters -filters: "['Payment Instruction Status','Equals','Active'],['Account Holder Name','Equals','#{var.NRIC.Name}']" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Wait and verify header -text: "#{var.NRIC.Name}" -options: "{partialMatch:true}"
    * D365CRM: Verify input lookup field value -field: "Stop Reason" -value: "" -options: ""
    * D365CRM: Click top menu button -field: "Go back" -options: ""
    * D365CRM: Table edit filter delete all and input new filters -filters: "['Payment Instruction Status','Equals','Inactive'],['Account Holder Name','Equals','#{var.NRIC.Name}']" -options: ""
    * D365CRM: Click link with text -field: "#{var.NRIC.Name}" -options: ""
    * D365CRM: Wait and verify header -text: "#{var.NRIC.Name}" -options: "{partialMatch:true}"
    * D365CRM: Verify input field value -field: "Recurring Payment set up type" -value: "<Recurring_Payment_setup_type>" -options: ""
    * D365CRM: Verify input field value -field: "Stop Reason" -value: "<Stop_Reason>" -options: ""
    * D365CRM: Verify input field value -field: "Stop Code" -value: "<Stop_Code>" -options: ""
    * D365CRM: Logout from Dynamics -options: ""

    Examples: { "dataFile": "test-data/ntuc.xlsx","filter": "_ID===\"SC01\" && _STATUS===true" }
#   @SC01B
#   @SC01B_TestData
#   @PRIORITY:3
#   Scenario Outline: Scenario SC01B - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F3, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3,${var.NRIC})"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3,${var.PersonFullName})"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F3,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC01\"'}
#   @SC01B
#   @SC01B_RPI_Validation
#   @PRIORITY:4
#   Scenario Outline: Scenario SC01B - Validate Stop code when case status is Rejected
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z4, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA4,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB4, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I scroll to an element "loc.athena.scroll.till.RejectionReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Rejection Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Rejected" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E4,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F4,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G4,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H4,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I4,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J4,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K4,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L4,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M4,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N4,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O4,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P4,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q4,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R4,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S4,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T4,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U4,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V4,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W4,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X4,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y4,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z4,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB4,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA4,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC02\"'}
#   @SC01C
#   @SC01C_TestData
#   @PRIORITY:5
#   Scenario Outline: Scenario SC01C - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D4, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E4, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F4, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D4,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E4,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F4,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC01\"'}
#   @SC01C
#   @SC01C_RPI_Validation
#   @PRIORITY:6
#   Scenario Outline: Scenario SC01C - Validate Stop code when case status is Cancelled (After Approved)
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z5, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA5,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB5, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I scroll to an element "loc.athena.scroll.till.CancelledReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Cancelled Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Cancelled" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E5,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F5,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G5,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H5,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I5,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J5,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K5,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L5,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M5,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N5,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O5,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P5,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q5,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R5,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S5,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T5,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U5,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V5,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W5,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X5,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y5,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z5,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB5,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA5,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC03\"'}
#   @SC02A
#   @SC02A_TestData
#   @PRIORITY:7
#   Scenario Outline: Scenario SC02A - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D5, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E5, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F5, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D5,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E5,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F5,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC02\"'}
#   @SC02A
#   @SC02A_RPI_Validation
#   @PRIORITY:8
#   Scenario Outline: Scenario SC02A - Validate Stop code when case status is Draft, In Progress, Approved & Completed
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z6, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA6,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB6, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "2" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason5>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode5>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * I wait for "8" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E6,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G6,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H6,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I6,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J6,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K6,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L6,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M6,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P6,<Target_Payment_Mode>)"
#     #execute Batch job to change effective transfer date to current/past.
#     Given I wait for "6" seconds
#     * I store value "<Case_Number>" into variable "var.CaseNumber"
#     * I call api "${api.athena.change.date.transfercase.baseUrl1}" with method "POST" and header "${api.athena.change.date.transfercase.headers1}" and payload "${api.athena.change.date.transfercase.body1}" bypassing SSL
#     * I wait for "5" seconds
#     #execute Batch job to change case status to completed.
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for "4" seconds
#     * D365CRM: Switch-App From:"NTUC ATHENA" To:"Batch Jobs Administration"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Active Master Batch Jobs" Page:"Batch Job Master"
#     * D365CRM: Input Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Field:"Batch Job Master Filter by keyword" Page:"Active Master Batch Jobs"
#     * I press RETURN or ENTER key
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Batch Job Master"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Page:"Batch Job Master"
#     * D365CRM: Click-Top-Menu-Button Text:"Trigger Job" Page:"Batch Job Master"
#     * D365CRM: Click-Button Field:"OK" Page:"Batch Job Master::DIALOG_WINDOW"
#     * I wait for "10" seconds
#     * D365CRM: Switch-App From:"Batch Jobs Administration" To:"NTUC ATHENA"
#     Given I wait for "10" seconds
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Completed" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','NEW'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','TRANSFERRED'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Draft'],['NRIC/FIN','Equals','<NRIC>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     #Check Source Stop Code
#     * I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Inactive'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason3>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode3>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F6,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N6,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O6,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q6,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R6,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S6,<StopCode3>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T6,<StopReason3>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U6,<Target_Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V6,<Target_Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W6,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X6,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y6,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z6,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB6,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA6,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC04\"'}
#   @SC02B
#   @SC02B_TestData
#   @PRIORITY:9
#   Scenario Outline: Scenario SC02B - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D6, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E6, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F6, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D6,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E6,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F6,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC02\"'}
#   @SC02B
#   @SC02B_RPI_Validation
#   @PRIORITY:10
#   Scenario Outline: Scenario SC02B - Validate Stop code when case status is Rejected
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z7, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA7,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB7, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.RejectionReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Rejection Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Rejected" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "10" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E7,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F7,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G7,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H7,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I7,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J7,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K7,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L7,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M7,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N7,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O7,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P7,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q7,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R7,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S7,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T7,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U7,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V7,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W7,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X7,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y7,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z7,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB7,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA7,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC05\"'}
#   @SC02C
#   @SC02C_TestData
#   @PRIORITY:11
#   Scenario Outline: Scenario SC02C - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D7, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E7, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F7, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D7,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E7,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F7,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC02\"'}
#   @SC02C
#   @SC02C_RPI_Validation
#   @PRIORITY:12
#   Scenario Outline: Scenario SC02C - Validate Stop code when case status is Cancelled (After Approved)
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z8, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA8,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB8, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     * I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.CancelledReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Cancelled Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Cancelled" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E8,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F8,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G8,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H8,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I8,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J8,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K8,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L8,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M8,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N8,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O8,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P8,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q8,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R8,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S8,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T8,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U8,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V8,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W8,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X8,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y8,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z8,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB8,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA8,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC06\"'}
#   @SC05A
#   @SC05B
#   @SC05C
#   @PRIORITY:13
#   Scenario Outline: Scenario SC05A, SC05B & SC05C - Create Membership, RPI, Transfer Case and validate
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D14, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E14, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F14, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D15, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E15, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F15, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D16, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E16, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F16, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Lookup Text:"${StopReason6}" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"${StopCode6}" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Text:"Business Process Error" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Text:"Member did not pay for the 1st month under GB." Page:"Cases/Requests"
#     * D365CRM: Click-Popup-Button Text:"OK"
#     * I comment "Case Number not created."
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D14,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E14,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F14,Empty)"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D15,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E15,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F15,Empty)"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D16,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E16,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F16,Empty)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA9,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB9, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA10,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB10, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA11,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB11, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E9,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F9,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q9,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R9,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S9,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T9,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z9,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB9,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC9,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA9,Passed)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E10,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F10,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q10,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R10,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S10,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T10,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z10,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB10,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC10,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA10,Passed)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E11,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F11,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q11,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R11,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S11,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T11,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z11,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB11,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC11,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA11,Passed)"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC05\"'}
#   @SC06A
#   @SC06B
#   @SC06C
#   @PRIORITY:14
#   Scenario Outline: Scenario SC06A, SC06B & SC06C - Create Membership, RPI, Transfer Case and validate
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D17, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E17, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F17, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D18, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E18, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F18, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D19, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E19, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F19, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Lookup Text:"${StopReason6}" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"${StopCode6}" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Text:"Business Process Error" Page:"Cases/Requests"
#     * D365CRM: Verify-Text:"Member did not pay for the 1st month under GB." Page:"Cases/Requests"
#     * D365CRM: Click-Popup-Button Text:"OK"
#     * I comment "Case Number not created."
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D17,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E17,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F17,Empty)"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D18,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E18,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F18,Empty)"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D19,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E19,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F19,Empty)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA12,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB12, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA13,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB13, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA14,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB14, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E12,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F12,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q12,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R12,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S12,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T12,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z12,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB12,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC12,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA12,Passed)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E13,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F13,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q13,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R13,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S13,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T13,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z13,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB13,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC13,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA13,Passed)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E14,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F14,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q14,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R14,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S14,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T14,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z14,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB14,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC14,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA14,Passed)"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC06\"'}
#   @SC07A
#   @SC07B
#   @SC07C
#   @PRIORITY:15
#   Scenario Outline: Scenario SC07A, SC07B & SC07C - Create Membership, RPI, Transfer Case and validate
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D20, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E20, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F20, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D21, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E21, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F21, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D22, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E22, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F22, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Lookup Text:"${StopReason6}" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"${StopCode6}" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Text:"Business Process Error" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Text:"Member did not pay for the 1st month under GB." Page:"Cases/Requests"
#     * D365CRM: Click-Popup-Button Text:"OK"
#     * I comment "Case Number not created."
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D20,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E20,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F20,Empty)"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D21,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E21,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F21,Empty)"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D22,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E22,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F22,Empty)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA15,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB15, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA16,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB16, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA17,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB17, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E15,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F15,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q15,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R15,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S15,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T15,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z15,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB15,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC15,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA15,Passed)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E16,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F16,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q16,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R16,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S16,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T16,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z16,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB16,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC16,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA16,Passed)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E17,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F17,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q17,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R17,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S17,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T17,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z17,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB17,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC17,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA17,Passed)"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC07\"'}
#   @SC08A
#   @SC08B
#   @SC08C
#   @PRIORITY:16
#   Scenario Outline: Scenario SC08A, SC08B & SC08C - Create Membership, RPI, Transfer Case and validate
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D23, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E23, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F23, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D24, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E24, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F24, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D25, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E25, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F25, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Lookup Text:"${StopReason6}" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"${StopCode6}" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Text:"Business Process Error" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Text:"Member did not pay for the 1st month under GB." Page:"Cases/Requests"
#     * D365CRM: Click-Popup-Button Text:"OK"
#     * I comment "Case Number not created."
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D23,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E23,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F23,Empty)"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D24,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E24,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F24,Empty)"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D25,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E25,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F25,Empty)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA18,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB18, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA19,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB19, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA20,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB20, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E18,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F18,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q18,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R18,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S18,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T18,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z18,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB18,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC18,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA18,Passed)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E19,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F19,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q19,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R19,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S19,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T19,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z19,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB19,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC19,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA19,Passed)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E20,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F20,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q20,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R20,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S20,${StopCode6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T20,${StopReason6})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z20,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB20,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AC20,Member did not pay for the 1st month under GB.)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA20,Passed)"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC08\"'}
#   @SC09A
#   @SC09A_TestData
#   @PRIORITY:17
#   Scenario Outline: Scenario SC09A - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D26, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E26, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F26, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for page to load
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * I wait for "2" seconds
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * I wait for page to load
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for page to load
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D26,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E26,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F26,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC09\"'}
#   @SC09A
#   @SC09A_RPI
#   @PRIORITY:18
#   Scenario Outline: Scenario SC09A - Validate Stop code when case status is Draft, In Progress, Approved & Completed
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z21, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA21,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB21, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "2" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason2>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode2>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * I wait for "8" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.LastDayOfNextMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E21,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G21,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H21,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I21,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J21,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K21,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L21,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M21,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P21,<Target_Payment_Mode>)"
#     #execute Batch job to change effective transfer date to current/past.
#     Given I wait for "6" seconds
#     * I store value "<Case_Number>" into variable "var.CaseNumber"
#     * I call api "${api.athena.change.date.transfercase.baseUrl1}" with method "POST" and header "${api.athena.change.date.transfercase.headers1}" and payload "${api.athena.change.date.transfercase.body1}" bypassing SSL
#     * I wait for "5" seconds
#     #execute Batch job to change case status to completed.
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for "4" seconds
#     * D365CRM: Switch-App From:"NTUC ATHENA" To:"Batch Jobs Administration"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Active Master Batch Jobs" Page:"Batch Job Master"
#     * D365CRM: Input Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Field:"Batch Job Master Filter by keyword" Page:"Active Master Batch Jobs"
#     * I press RETURN or ENTER key
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Batch Job Master"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Page:"Batch Job Master"
#     * D365CRM: Click-Top-Menu-Button Text:"Trigger Job" Page:"Batch Job Master"
#     * D365CRM: Click-Button Field:"OK" Page:"Batch Job Master::DIALOG_WINDOW"
#     * I wait for "10" seconds
#     * D365CRM: Switch-App From:"Batch Jobs Administration" To:"NTUC ATHENA"
#     Given I wait for "10" seconds
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Completed" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','NEW'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','TRANSFERRED'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Active'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     #Check Source Stop Code
#     * I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Inactive'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason2>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode2>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F21,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N21,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O21,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q21,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R21,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S21,<StopCode2>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T21,<StopReason2>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U21,<Target_Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V21,<Target_Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W21,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X21,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y21,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z21,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB21,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA21,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC25\"'}
#   @SC09B
#   @SC09B_TestData
#   @PRIORITY:19
#   Scenario Outline: Scenario SC09B - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D27, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E27, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F27, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3,${var.NRIC})"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3,${var.PersonFullName})"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * I wait for "2" seconds
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F3,${var.CaseNumber})"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D27,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E27,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F27,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC09\"'}
#   @SC09B
#   @SC09B_RPI_Validation
#   @PRIORITY:20
#   Scenario Outline: Scenario SC09B - Validate Stop code when case status is Rejected
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z22, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA22,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB22, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I scroll to an element "loc.athena.scroll.till.RejectionReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Rejection Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Rejected" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.LastDayOfNextMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E22,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F22,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G22,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H22,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I22,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J22,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K22,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L22,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M22,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N22,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O22,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P22,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q22,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R22,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S22,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T22,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U22,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V22,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W22,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X22,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y22,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z22,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB22,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA22,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC26\"'}
#   @SC09C
#   @SC09C_TestData
#   @PRIORITY:21
#   Scenario Outline: Scenario SC09C - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D28, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E28, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F28, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D28,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E28,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F28,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC09\"'}
#   @SC09C
#   @SC09C_RPI_Validation
#   @PRIORITY:22
#   Scenario Outline: Scenario SC09C - Validate Stop code when case status is Cancelled (After Approved)
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z23, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA23,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB23, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I scroll to an element "loc.athena.scroll.till.CancelledReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Cancelled Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Cancelled" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.LastDayOfNextMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E23,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F23,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G23,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H23,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I23,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J23,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K23,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L23,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M23,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N23,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O23,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P23,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q23,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R23,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S23,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T23,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U23,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V23,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W23,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X23,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y23,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z23,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB23,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA23,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC27\"'}
#   @SC10A
#   @SC10A_TestData
#   @PRIORITY:17
#   Scenario Outline: Scenario SC10A - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D29, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E29, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F29, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * I wait for "2" seconds
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D29,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E29,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F29,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC10\"'}
#   @SC10A
#   @SC10A_RPI
#   @PRIORITY:18
#   Scenario Outline: Scenario SC10A - Validate Stop code when case status is Draft, In Progress, Approved & Completed
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z24, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA24,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB24, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "2" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason5>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode5>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * I wait for "8" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.LastDayOfNextMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E24,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G24,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H24,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I24,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J24,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K24,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L24,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M24,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P24,<Target_Payment_Mode>)"
#     #execute Batch job to change effective transfer date to current/past.
#     Given I wait for "6" seconds
#     * I store value "<Case_Number>" into variable "var.CaseNumber"
#     * I call api "${api.athena.change.date.transfercase.baseUrl1}" with method "POST" and header "${api.athena.change.date.transfercase.headers1}" and payload "${api.athena.change.date.transfercase.body1}" bypassing SSL
#     * I wait for "5" seconds
#     #execute Batch job to change case status to completed.
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for "4" seconds
#     * D365CRM: Switch-App From:"NTUC ATHENA" To:"Batch Jobs Administration"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Active Master Batch Jobs" Page:"Batch Job Master"
#     * D365CRM: Input Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Field:"Batch Job Master Filter by keyword" Page:"Active Master Batch Jobs"
#     * I press RETURN or ENTER key
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Batch Job Master"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Page:"Batch Job Master"
#     * D365CRM: Click-Top-Menu-Button Text:"Trigger Job" Page:"Batch Job Master"
#     * D365CRM: Click-Button Field:"OK" Page:"Batch Job Master::DIALOG_WINDOW"
#     * I wait for "10" seconds
#     * D365CRM: Switch-App From:"Batch Jobs Administration" To:"NTUC ATHENA"
#     Given I wait for "10" seconds
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Completed" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','NEW'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','TRANSFERRED'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Draft'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     #Check Source Stop Code
#     * I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Inactive'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason3>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode3>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F24,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N24,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O24,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q24,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R24,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S24,<StopCode3>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T24,<StopReason3>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U24,<Target_Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V24,<Target_Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W24,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X24,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y24,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z24,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB24,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA24,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC28\"'}
#   @SC10B
#   @SC10B_TestData
#   @PRIORITY:19
#   Scenario Outline: Scenario SC10B - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D30, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E30, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F30, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3,${var.NRIC})"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3,${var.PersonFullName})"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * I wait for "2" seconds
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F3,${var.CaseNumber})"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D30,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E30,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F30,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC10\"'}
#   @SC10B
#   @SC10B_RPI_Validation
#   @PRIORITY:20
#   Scenario Outline: Scenario SC10B - Validate Stop code when case status is Rejected
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z25, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA25,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB25, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.RejectionReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Rejection Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Rejected" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.LastDayOfNextMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E25,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F25,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G25,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H25,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I25,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J25,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K25,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L25,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M25,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N25,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O25,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P25,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q25,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R25,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S25,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T25,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U25,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V25,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W25,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X25,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y25,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z25,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB25,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA25,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC29\"'}
#   @SC10C
#   @SC10C_TestData
#   @PRIORITY:21
#   Scenario Outline: Scenario SC10C - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D31, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E31, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F31, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D31,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E31,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F31,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC10\"'}
#   @SC10C
#   @SC10C_RPI_Validation
#   @PRIORITY:22
#   Scenario Outline: Scenario SC10C - Validate Stop code when case status is Cancelled (After Approved)
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z26, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA26,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB26, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.CancelledReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Cancelled Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Cancelled" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.LastDayOfNextMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E26,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F26,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G26,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H26,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I26,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J26,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K26,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L26,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M26,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N26,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O26,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P26,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q26,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R26,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S26,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T26,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U26,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V26,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W26,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X26,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y26,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z26,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB26,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA26,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC30\"'}
#   @SC13A
#   @SC13A_TestData
#   @PRIORITY:23
#   Scenario Outline: Scenario SC13A - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D38, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E38, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F38, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * I wait for "6" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for page to load
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for page to load
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Recurring Payment Instruction"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D38,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E38,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F38,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC13\"'}
#   @SC13A
#   @SC13A_RPI_Validation
#   @PRIORITY:24
#   Scenario Outline: Scenario SC13A - Validate Stop code when case status is Draft, In Progress, Approved & Completed
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z27, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA27,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB27, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "2" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason2>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode2>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * I wait for page to load
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * I wait for "8" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E27,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G27,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H27,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I27,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J27,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K27,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L27,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M27,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P27,<Target_Payment_Mode>)"
#     #execute Batch job to change effective transfer date to current/past.
#     Given I wait for "6" seconds
#     * I store value "<Case_Number>" into variable "var.CaseNumber"
#     * I call api "${api.athena.change.date.transfercase.baseUrl1}" with method "POST" and header "${api.athena.change.date.transfercase.headers1}" and payload "${api.athena.change.date.transfercase.body1}" bypassing SSL
#     * I wait for "5" seconds
#     #execute Batch job to change case status to completed.
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for "4" seconds
#     * D365CRM: Switch-App From:"NTUC ATHENA" To:"Batch Jobs Administration"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Active Master Batch Jobs" Page:"Batch Job Master"
#     * D365CRM: Input Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Field:"Batch Job Master Filter by keyword" Page:"Active Master Batch Jobs"
#     * I press RETURN or ENTER key
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Batch Job Master"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Page:"Batch Job Master"
#     * D365CRM: Click-Top-Menu-Button Text:"Trigger Job" Page:"Batch Job Master"
#     * D365CRM: Click-Button Field:"OK" Page:"Batch Job Master::DIALOG_WINDOW"
#     * I wait for "10" seconds
#     * D365CRM: Switch-App From:"Batch Jobs Administration" To:"NTUC ATHENA"
#     Given I wait for "10" seconds
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Completed" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','NEW'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','TRANSFERRED'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Active'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     #Check Source Stop Code
#     * I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Inactive'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason2>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode2>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F27,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N27,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O27,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q27,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R27,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S27,<StopCode2>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T27,<StopReason2>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U27,<Target_Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V27,<Target_Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W27,<StopCode6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X27,<StopReason6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y27,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z27,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB27,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA27,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC37\"'}
#   @SC13B
#   @SC13B_TestData
#   @PRIORITY:25
#   Scenario Outline: Scenario SC13B - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D39, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E39, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F39, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3,${var.NRIC})"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3,${var.PersonFullName})"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * I wait for "2" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<Stop_Reason>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F3,${var.CaseNumber})"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D39,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E39,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F39,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC13\"'}
#   @SC13B
#   @SC13B_RPI_Validation
#   @PRIORITY:26
#   Scenario Outline: Scenario SC13B - Validate Stop code when case status is Rejected
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z28, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA28,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB28, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.RejectionReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Rejection Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Rejected" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E28,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F28,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G28,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H28,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I28,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J28,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K28,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L28,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M28,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N28,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O28,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P28,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q28,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R28,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S28,<StopCode6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T28,<StopReason6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB28,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA28,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC38\"'}
#   @SC13C
#   @SC13C_TestData
#   @PRIORITY:27
#   Scenario Outline: Scenario SC13C - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D40, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E40, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F40, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D40,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E40,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F40,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC13\"'}
#   @SC13C
#   @SC13C_RPI_Validation
#   @PRIORITY:28
#   Scenario Outline: Scenario SC13C - Validate Stop code when case status is Cancelled (After Approved)
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z29, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA29,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB29, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.CancelledReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Cancelled Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Cancelled" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E28,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F28,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G28,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H28,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I28,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J28,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K28,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L28,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M28,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N28,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O28,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P28,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q28,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R28,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S28,<StopCode6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T28,<StopReason6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z28,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB28,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA28,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC39\"'}
#   @SC14A
#   @SC14A_TestData
#   @PRIORITY:29
#   Scenario Outline: Scenario SC14A - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D41, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E41, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F41, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * I wait for "2" seconds
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * I wait for "6" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for page to load
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for page to load
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<Stop_Reason>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
# #    * D365CRM: Verify-Input-Lookup Text:"<Stop_Code>" Field:"Stop Code" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Recurring Payment Instruction"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D41,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E41,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F41,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC14\"'}
#   @SC14A
#   @SC14A_RPI_Validation
#   @PRIORITY:30
#   Scenario Outline: Scenario SC14A - Validate Stop code when case status is Draft, In Progress, Approved & Completed
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z30, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA30,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB30, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "2" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason5>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode5>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * I wait for page to load
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * I wait for "8" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E30,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G30,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H30,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I30,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J30,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K30,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L30,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M30,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P30,<Target_Payment_Mode>)"
#     #execute Batch job to change effective transfer date to current/past.
#     Given I wait for "6" seconds
#     * I store value "<Case_Number>" into variable "var.CaseNumber"
#     * I call api "${api.athena.change.date.transfercase.baseUrl1}" with method "POST" and header "${api.athena.change.date.transfercase.headers1}" and payload "${api.athena.change.date.transfercase.body1}" bypassing SSL
#     * I wait for "5" seconds
#     #execute Batch job to change case status to completed.
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for "4" seconds
#     * D365CRM: Switch-App From:"NTUC ATHENA" To:"Batch Jobs Administration"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Active Master Batch Jobs" Page:"Batch Job Master"
#     * D365CRM: Input Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Field:"Batch Job Master Filter by keyword" Page:"Active Master Batch Jobs"
#     * I press RETURN or ENTER key
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Batch Job Master"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Page:"Batch Job Master"
#     * D365CRM: Click-Top-Menu-Button Text:"Trigger Job" Page:"Batch Job Master"
#     * D365CRM: Click-Button Field:"OK" Page:"Batch Job Master::DIALOG_WINDOW"
#     * I wait for "10" seconds
#     * D365CRM: Switch-App From:"Batch Jobs Administration" To:"NTUC ATHENA"
#     Given I wait for "10" seconds
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Completed" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','NEW'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','TRANSFERRED'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Draft'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     #Check Source Stop Code
#     * I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Inactive'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason3>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode3>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F30,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N30,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O30,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q30,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R30,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S30,<StopCode3>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T30,<StopReason3>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U30,<Target_Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V30,<Target_Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W30,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X30,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y30,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z30,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB30,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA30,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC40\"'}
#   @SC14B
#   @SC14B_TestData
#   @PRIORITY:31
#   Scenario Outline: Scenario SC14B - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D42, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E42, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F42, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3,${var.NRIC})"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3,${var.PersonFullName})"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * I wait for page to load
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * I wait for "2" seconds
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F3,${var.CaseNumber})"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D42,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E42,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F42,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC14\"'}
#   @SC14B
#   @SC14B_RPI_Validation
#   @PRIORITY:32
#   Scenario Outline: Scenario SC14B - Validate Stop code when case status is Rejected
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z31, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA31,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB31, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.RejectionReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Rejection Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Rejected" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E31,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F31,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G31,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H31,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I31,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J31,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K31,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L31,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M31,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N31,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O31,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P31,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q31,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R31,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S31,<StopCode6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T31,<StopReason6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U31,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V31,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W31,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X31,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y31,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z31,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB31,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA31,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC41\"'}
#   @SC14C
#   @SC14C_TestData
#   @PRIORITY:33
#   Scenario Outline: Scenario SC14C - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D43, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E43, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F43, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Input-Date Text:"${var.LastDayOfNextMonth}" Field:"Period To" Page:"Memberships"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D43,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E43,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F43,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC14\"'}
#   @SC14C
#   @SC14C_RPI_Validation
#   @PRIORITY:34
#   Scenario Outline: Scenario SC14C - Validate Stop code when case status is Cancelled (After Approved)
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z32, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA32,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB32, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.CancelledReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Cancelled Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Cancelled" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason6>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode6>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E32,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F32,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G32,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H32,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I32,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J32,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K32,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L32,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M32,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N32,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O32,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P32,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q32,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R32,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S32,<StopCode6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T32,<StopReason6>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U32,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V32,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W32,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X32,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y32,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z32,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB32,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA32,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC42\"'}
#   @SC17A
#   @SC17A_TestData
#   @PRIORITY:35
#   Scenario Outline: Scenario SC17A - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D50, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E50, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F50, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Button Field:"Refresh" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Remove Delayed Deduction" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Popup-Button Text:"Proceed"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * I wait for "2" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * I wait for "6" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for page to load
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for page to load
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<Stop_Reason>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Recurring Payment Instruction"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D50,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E50,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F50,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC17\"'}
#   @SC17A
#   @SC17A_RPI_Validation
#   @PRIORITY:36
#   Scenario Outline: Scenario SC17A - Validate Stop code when case status is Draft, In Progress, Approved & Completed
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z33, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA33,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB33, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "2" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason2>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode2>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * I wait for page to load
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * I wait for "8" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E33,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G33,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H33,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I33,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J33,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K33,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L33,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M33,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P33,<Target_Payment_Mode>)"
#     #execute Batch job to change effective transfer date to current/past.
#     Given I wait for "6" seconds
#     * I store value "<Case_Number>" into variable "var.CaseNumber"
#     * I call api "${api.athena.change.date.transfercase.baseUrl1}" with method "POST" and header "${api.athena.change.date.transfercase.headers1}" and payload "${api.athena.change.date.transfercase.body1}" bypassing SSL
#     * I wait for "5" seconds
#     #execute Batch job to change case status to completed.
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for "4" seconds
#     * D365CRM: Switch-App From:"NTUC ATHENA" To:"Batch Jobs Administration"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Active Master Batch Jobs" Page:"Batch Job Master"
#     * D365CRM: Input Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Field:"Batch Job Master Filter by keyword" Page:"Active Master Batch Jobs"
#     * I press RETURN or ENTER key
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Batch Job Master"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Page:"Batch Job Master"
#     * D365CRM: Click-Top-Menu-Button Text:"Trigger Job" Page:"Batch Job Master"
#     * D365CRM: Click-Button Field:"OK" Page:"Batch Job Master::DIALOG_WINDOW"
#     * I wait for "10" seconds
#     * D365CRM: Switch-App From:"Batch Jobs Administration" To:"NTUC ATHENA"
#     Given I wait for "10" seconds
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Completed" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','NEW'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','TRANSFERRED'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Active'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     #Check Source Stop Code
#     * I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Inactive'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason2>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode2>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F33,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N33,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O33,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q33,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R33,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S33,<StopCode2>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T33,<StopReason2>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U33,<Target_Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V33,<Target_Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W33,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X33,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y33,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z33,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB33,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA33,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC49\"'}
#   @SC17B
#   @SC17B_TestData
#   @PRIORITY:37
#   Scenario Outline: Scenario SC17B - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D51, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E51, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F51, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3,${var.NRIC})"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3,${var.PersonFullName})"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Button Field:"Refresh" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Remove Delayed Deduction" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Popup-Button Text:"Proceed"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * I wait for "2" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F3,${var.CaseNumber})"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D51,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E51,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F51,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC17\"'}
#   @SC17B
#   @SC17B_RPI_Validation
#   @PRIORITY:38
#   Scenario Outline: Scenario SC17B - Validate Stop code when case status is Rejected
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z34, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA34,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB34, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.RejectionReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Rejection Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Rejected" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E34,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F34,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G34,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H34,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I34,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J34,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K34,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L34,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M34,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N34,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O34,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P34,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q34,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R34,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S34,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T34,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U34,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V34,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W34,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X34,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y34,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z34,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB34,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA34,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC50\"'}
#   @SC17C
#   @SC17C_TestData
#   @PRIORITY:39
#   Scenario Outline: Scenario SC17C - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D52, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E52, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F52, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Button Field:"Refresh" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Remove Delayed Deduction" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Popup-Button Text:"Proceed"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D52,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E52,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F52,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC17\"'}
#   @SC17C
#   @SC17C_RPI_Validation
#   @PRIORITY:40
#   Scenario Outline: Scenario SC17C - Validate Stop code when case status is Cancelled (After Approved)
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z35, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA35,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB35, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.CancelledReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Cancelled Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Cancelled" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "1" in format "M/d/yyyy" into variable "var.1BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.1BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E35,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F35,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G35,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H35,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I35,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J35,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K35,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L35,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M35,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N35,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O35,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P35,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q35,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R35,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S35,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T35,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U35,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V35,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W35,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X35,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y35,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z35,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB35,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA35,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC51\"'}
#   @SC18A
#   @SC18A_TestData
#   @PRIORITY:41
#   Scenario Outline: Scenario SC18A - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D53, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E53, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F53, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Button Field:"Refresh" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Remove Delayed Deduction" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Popup-Button Text:"Proceed"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * I wait for "2" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * I wait for "6" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for page to load
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for page to load
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<Stop_Reason>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * I wait for "6" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Recurring Payment Instruction"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D53,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E53,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F53,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC18\"'}
#   @SC18A
#   @SC18A_RPI_Validation
#   @PRIORITY:42
#   Scenario Outline: Scenario SC18A - Validate Stop code when case status is Draft, In Progress, Approved & Completed
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z36, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA36,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB36, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "2" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     Given I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * I wait for page to load
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * I wait for page to load
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason5>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode5>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection"
#     * I comment "Test Passed"
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * I wait for page to load
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     Given I wait for "10" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     * I wait for "8" seconds
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E36,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G36,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H36,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I36,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J36,${var.6BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K36,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L36,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M36,${var.lastDayOfCurrentMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P36,<Target_Payment_Mode>)"
#     #execute Batch job to change effective transfer date to current/past.
#     Given I wait for "6" seconds
#     * I store value "<Case_Number>" into variable "var.CaseNumber"
#     * I call api "${api.athena.change.date.transfercase.baseUrl1}" with method "POST" and header "${api.athena.change.date.transfercase.headers1}" and payload "${api.athena.change.date.transfercase.body1}" bypassing SSL
#     * I wait for "5" seconds
#     #execute Batch job to change case status to completed.
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for "4" seconds
#     * D365CRM: Switch-App From:"NTUC ATHENA" To:"Batch Jobs Administration"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Active Master Batch Jobs" Page:"Batch Job Master"
#     * D365CRM: Input Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Field:"Batch Job Master Filter by keyword" Page:"Active Master Batch Jobs"
#     * I press RETURN or ENTER key
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Batch Job Master"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"D365 MBRSHP INDIVIDUAL MEMBERSHIP TRANSFER" Page:"Batch Job Master"
#     * D365CRM: Click-Top-Menu-Button Text:"Trigger Job" Page:"Batch Job Master"
#     * D365CRM: Click-Button Field:"OK" Page:"Batch Job Master::DIALOG_WINDOW"
#     * I wait for "10" seconds
#     * D365CRM: Switch-App From:"Batch Jobs Administration" To:"NTUC ATHENA"
#     Given I wait for "10" seconds
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Completed" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','NEW'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Target_Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"Union Memberships" Page:"Memberships"
#     * D365CRM: Click-Main-System-View Text:"Union Memberships" Then-Sub-System-View Text:"All Memberships" Page:"Memberships"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Membership Status','Equals','TRANSFERRED'],['Full Name (as per NRIC)','Equals','<Person_Name>']" Page:"Memberships"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Union Memberships"
#     * I wait for "3" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"<Person_Name>" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Membership Management"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Draft'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     #Check Source Stop Code
#     * I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Table-Edit-Filter-Delete-All-And-Input-New filters:"['Payment Instruction Status','Equals','Inactive'],['Account Holder Name','Equals','<Person_Name>']" Page:"Recurring Payment Instructions*"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason3>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<StopCode3>" Field:"Stop Code" Attribute:"value" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F36,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N36,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O36,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q36,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R36,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S36,<StopCode3>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T36,<StopReason3>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U36,<Target_Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V36,<Target_Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W36,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X36,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y36,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z36,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB36,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA36,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC52\"'}
#   @SC18B
#   @SC18B_TestData
#   @PRIORITY:43
#   Scenario Outline: Scenario SC18B - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D54, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E54, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F54, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * I wait for page to load
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D3,${var.NRIC})"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E3,${var.PersonFullName})"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership"
#     * D365CRM: Click-Button Field:"Refresh" Page:"Membership"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership"
#     * I wait for "10" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Remove Delayed Deduction" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Popup-Button Text:"Proceed"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * I wait for "2" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "3" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * I wait for "4" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F3,${var.CaseNumber})"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D54,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E54,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F54,${var.CaseNumber})"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC18\"'}
#   @SC18B
#   @SC18B_RPI_Validation
#   @PRIORITY:44
#   Scenario Outline: Scenario SC18B - Validate Stop code when case status is Rejected
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z37, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA37,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB37, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "2" seconds
#     * I scroll to an element "loc.athena.scroll.till.RejectionReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Rejection Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Reject" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Rejected" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"<StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E37,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F37,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G37,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H37,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I37,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J37,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K37,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L37,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M37,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N37,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O37,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P37,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q37,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R37,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S37,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T37,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U37,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V37,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W37,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X37,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y37,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z37,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB37,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA37,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC53\"'}
#   @SC18C
#   @SC18C_TestData
#   @PRIORITY:45
#   Scenario Outline: Scenario SC18C - Create Membership, RPI and Transfer Case
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D55, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E55, )"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F55, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     Given D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"New" Page:"Membership Applications"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Membership Application" Page:"Membership Applications"
#     * Utils: Generate Singapore NRIC for a citizen with type "S" and year "1984" into variable "var.NRIC"
#     * D365CRM: Input Text:"${var.NRIC}" Field:"NRIC/FIN" Page:"Membership Applications"
#     * Utils: Get year from Singapore NRIC "${var.NRIC}" into variable "var.NRIC.Date"
#     * D365CRM: Input-Date Text:"1/4/${var.NRIC.Date}" Field:"Date of Birth" Page:"Membership Applications"
#     * Utils: Generate unique Singapore name and store into variable "var.PersonName"
#     * I store value "STCR ${var.PersonName}" into variable "var.PersonFullName"
#     * D365CRM: Input Text:"${var.PersonFullName}" Field:"Full Name (as per NRIC)" Page:"Membership Applications"
#     * D365CRM: Input Text:"stcr${var.NRIC}@ntuc.sg" Field:"Email" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Mobile_Phone>" Field:"Mobile Phone" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Race>" Field:"Race" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Education_Level>" Field:"Education Level" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Gender>" Field:"Gender" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Marital_Status>" Field:"Marital Status" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Nationality>" Field:"Nationality, Lookup" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Residential_Status>" Field:"Residential Status" Page:"Membership Applications"
#     * D365CRM: Select Text:"<Employment_Type>" Field:"Employment Type" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Occupation>" Field:"Occupation" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Occupation_Group>" Field:"Occupation Group, Lookup" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Company>" Field:"Company, Lookup" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Postal_Code>" Field:"Postal Code" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Floor>" Field:"Floor" Page:"Membership Applications"
#     * D365CRM: Input Text:"<Unit>" Field:"Unit" Page:"Membership Applications"
#     Given I wait for "2" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Input-Date Text:"${var.LastFirstDay}" Field:"Joined Union Date" Page:"Membership Applications"
#     * D365CRM: Input-Lookup Text:"<Campaign_Code>" Field:"Campaign Code, Lookup" Page:"Membership Applications"
#     * I wait for "3" seconds
#     * D365CRM: Click-Button Field:"Save" Page:"Membership Applications"
#     * D365CRM: Click-Top-Menu-Button Text:"Actions More Commands. Actions" Then-Sub-Menu-Button Text:"Submit" Page:"Membership Applications"
#     * I switch to iFrame by id or name "ntuc_HTML.D365.BackDatePopup.html"
#     *   I click on "loc.athena.mem.iframe.button.proceed"
#     *   I switch to default window or frame
#     *   D365CRM: Click-Popup-Button Text:"OK"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     * D365CRM: Click-Button Field:"Refresh" Page:"Memberships"
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Remove Delayed Deduction" Page:"Membership"
#     * I wait for "6" seconds
#     * D365CRM: Click-Popup-Button Text:"Proceed"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Payment Details" Page:"Membership"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Payment Collection" Then-Sub-Menu-Button Text:"New Payment Collection" Page:"Membership"
#     * D365CRM: Select Text:"<Payment_Type>" Field:"Payment Type" Page:"Payment Collection"
#     * Utils: Generate last day of the next month in format "M/d/yyyy" into variable "var.LastDayOfNextMonth"
#     * D365CRM: Click-Button Field:"Save" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Payment received" Page:"Payment Collection"
#     * I wait for "3" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Payment Collection"
#     Given I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"More commands for Recurring Payment Instruction" Then-Sub-Menu-Button Text:"Recurring Payment Instruction" Page:"Memberships"
#     * D365CRM: Select Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Page:"New Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Input-Lookup Text:"<Bank>" Field:"Bank" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input Text:"<Bank_Account_Number>" Field:"Bank Account Number" Page:"New Recurring Payment Instruction"
#     * D365CRM: Input-Lookup Text:"<Bank_Branch>" Field:"Bank Branch" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     Given I wait for "3" seconds
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.finusername}" and "${env.finpassword}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home Page"
#     * I wait for "10" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instruction"
#     * I wait for "4" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * D365CRM: Select Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Page:"New Recurring Payment Instruction"
#     * D365CRM: Click-Top-Menu-Button Text:"Save" Page:"New Recurring Payment Instructions"
#     * D365CRM: Logout from Dynamics
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     * I wait for "4" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * D365CRM: Table-Input-Filter Text:"${var.NRIC}" Page:"Recurring Payment Instructions"
#     * I wait for "6" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instructions"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Payment_Instruction_Status>" Field:"Payment Instruction Status" Attribute:"value" Page:"New Recurring Payment Instruction"
#     * I wait for "2" seconds
#     * D365CRM: Verify-Input-Lookup Text:"" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Click-Lookup-Record-Link Field:"Membership" Page:"Membership Applications"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Tab Text:"Cases/Request" Page:"Memberships"
#     * D365CRM: Click-Button Field:"New Cases/Requests" Page:"Memberships"
#     * D365CRM: Wait-And-Verify-Page-Header Text:"New Cases/Requests" Page:"Cases/Requests"
#     * D365CRM: Select Text:"TRANSFER REQUEST" Field:"Category" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<Target_Company>" Field:"Target Company" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Employment_Type>" Field:"Target Employment Type" Page:"Cases/Requests"
# #    * D365CRM: Input-Lookup Text:"<Target_Union_Code>" Field:"Target Union Code" Page:"Cases/Requests"
# #    * I wait for "3" seconds
# #    * D365CRM: Input-Lookup Text:"<Target_Branch_Code>" Field:"Target Branch Code" Page:"Cases/Requests"
#     * D365CRM: Input Text:"<New_Occupation>" Field:"New Occupation" Page:"Cases/Requests"
#     * D365CRM: Input-Lookup Text:"<New_Occupation_Group>" Field:"New Occupation Group, Lookup" Page:"Cases/Requests"
#     * D365CRM: Select Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save (CTRL+S)" Page:"Cases/Requests"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"1" To-Variable:"var.CaseNumber" Page:"Cases/Request"
#     * I comment "${var.CaseNumber}"
#     Given I wait for "6" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Go back" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Click-Tab Text:"Membership Details" Page:"Membership Applications"
#     * I wait for "5" seconds
#     * I scroll to an element "loc.athena.scroll.till.DelayDeductionDetails"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Flag>" Field:"Delayed Deduction" Page:"Membership"
#     * D365CRM: Verify-Input-Value Text:"<Delayed_Deduction_Type>" Field:"Delayed Deduction Type" Page:"Membership"
#     * D365CRM: Logout from Dynamics
#     * I comment "Test Passed"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(D55,${var.NRIC})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(E55,${var.PersonFullName})"
#     * Utils: Write to Excel File:"resources/data/Transfer_Stop_Code_In_Out_Data.xlsx" Sheet:"Sheet1" CellData:"(F55,${var.CaseNumber})"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_Data.xlsx', 'sheetName':'Sheet1', 'filter':'SC_ID==\"SC18\"'}
#   @SC18C
#   @SC18C_RPI_Validation
#   @PRIORITY:46
#   Scenario Outline: Scenario SC18C - Validate Stop code when case status is Cancelled (After Approved)
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z38, )"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA38,Skipped)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB38, )"
#     Given D365CRM: Login to "Athena" with following details "${env.url}", "${env.username}" and "${env.password}"
#     Then D365CRM: Wait-And-Verify-Page-Header Text:"Dashboard Notification" Page:"Home"
#     * D365CRM: Click-Left-Menu Text:"Membership Management" Then-Sub-Menu Text:"Cases/Requests"
#     * I wait for "10" seconds
#     * D365CRM: Click-Main-System-View Text:"Case Interaction" Then-Sub-System-View Text:"All Cases" Page:"Case Interaction"
#     * I wait for "4" seconds
#     * D365CRM: Table-Input-Filter Text:"<Case_Number>" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Wait-And-Verify-Page-Header Text:"TRANSFER REQUEST" Page:"Cases/Requests"
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Draft" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Submit" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"In Progress" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Approve" Page:"Cases/Requests"
#     * I wait for "3" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Approved" Page:"Membership"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Popup-Button Text:"Yes"
#     * I wait for "10" seconds
#     * I scroll to an element "loc.athena.scroll.till.CancelledReason"
#     * D365CRM: Input Text:"Stop Code Test" Field:"Cancelled Reason" Page:"Cases/Requests"
#     * D365CRM: Click-Button Field:"Save" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Action" Then-Sub-Menu-Button Text:"Cancel" Page:"Cases/Requests"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Header-Control-List-Column-Value Column:"3" Text:"Cancelled" Page:"Membership"
#     * D365CRM: Store-Header-Control-List-Column-Value Column:"3" To-Variable:"var.CaseStatus" Page:"Cases/Request"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Top-Menu-Button Text:"Refresh" Page:"Cases/Requests"
#     * Utils: Generate first day of the next month in format "M/d/yyyy" into variable "var.FirstNextMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Effective Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"System Transfer Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"<Notice_Period>" Field:"Notice Period" Page:"Cases/Requests"
#     * Utils: Generate date from current date by adding business days "6" in format "M/d/yyyy" into variable "var.6BusinessDay"
#     * D365CRM: Verify-Input-Date Text:"${var.6BusinessDay}" Field:"Last Date to Reject Transfer" Page:"Cases/Requests"
#     * I wait for "6" seconds
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Type>" Field:"Type" Attribute:"value" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Value Text:"${var.FirstNextMonth}" Field:"Proposed Date Join Union" Page:"Cases/Requests"
#     * I wait for "4" seconds
#     * Utils: Generate first day of the last month in format "M/d/yyyy" into variable "var.LastFirstDay"
#     * D365CRM: Verify-Input-Value Text:"${var.LastFirstDay}" Field:"Union Join Date" Page:"Cases/Requests"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Target_Payment_Mode>" Field:"Target Payment Mode" Attribute:"value" Page:"Cases/Requests"
#     * I wait for "2" seconds
#     * Utils: Generate last day of the current month in format "M/d/yyyy" into variable "var.lastDayOfCurrentMonth"
#     * D365CRM: Verify-Input-Value Text:"${var.lastDayOfCurrentMonth}" Field:"Last Paid Month" Page:"Cases/Requests"
#     Given I wait for "5" seconds
#     * D365CRM: Click-Left-Menu Text:"Payment Collection" Then-Sub-Menu Text:"Recurring Payment Instructions"
#     * I wait for "3" seconds
#     * D365CRM: Table-Input-Filter Text:"<NRIC>" Page:"Recurring Payment Instruction"
#     * I wait for "3" seconds
#     * D365CRM: Double-Click-Table-Cell Row:"1" Column:"1" Page:"Recurring Payment Instruction"
#     * I wait for "5" seconds
#     * D365CRM: Verify-Input-Lookup Text:"StopReason1>" Field:"Stop Reason" Page:"Recurring Payment Instruction"
#     * D365CRM: Verify-Input-Attribute-Value Text:"<Recurring_Payment_setup_type>" Field:"Recurring Payment set up type" Attribute:"value" Page:"Recurring Payment Instruction"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(E38,${var.LastFirstDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(F38,<Recurring_Payment_setup_type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(G38,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(H38,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(I38,<Notice_Period>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(J38,${var.1BusinessDay})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(K38,<Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(L38,${var.FirstNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(M38,${var.LastDayOfNextMonth})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(N38,<Case_Number>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(O38,${var.CaseStatus})"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(P38,<Target_Payment_Mode>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Q38,<Delayed_Deduction_Flag>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(R38,<Delayed_Deduction_Type>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(S38,<StopCode1>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(T38,<StopReason1>[EMPTY])"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(U38,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(V38,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(W38,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(X38,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Y38,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(Z38,NA)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AB38,<NRIC>)"
#     * Utils: Write to Excel File:"resources/data/StopCode_Result.xlsx" Sheet:"Sheet1" CellData:"(AA38,Passed)"
#     * I comment "Test Passed"
#     Examples: {'dataFile':'resources/data/Transfer_Stop_Code_In_Out_Data.xlsx', 'sheetName':'Sheet1', 'filter':'TC_ID==\"TC54\"'}
