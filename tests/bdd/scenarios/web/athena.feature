 Feature: Athena Portal

#   @athena
#   Scenario Outline: Test Athena Portal
#     * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "<username>" -password: "<password>" -options: ""
#     * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
#     * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
#     # * D365CRM: Wait and verify header -text: "All Applications" -options: ""
#     * D365CRM: Click button -text: "New" -options: ""
#     * D365CRM: Input text -fieldName: "Full Name" -text: "#{faker.person.fullName()}" -options: ""
#     * D365CRM: Input lookup -field: "Nationality" -text: "SINGAPORE CITIZEN" -options: ""
#     * D365CRM: Input date into field -field: "Date of Birth" -date: "#{faker.custom.person.birthDate()}" -options: ""
#     * D365CRM: Verify field is mandatory -field: "Date of Birth" -options: ""
#     * D365CRM: Verify field is secured -field: "Date of Birth" -options: ""
#     * D365CRM: Verify input field value -field: "Membership Category" -value: "Union Membership" -options: ""
#    # * D365CRM: Verify locked input field value -field: "Recruitment Channel" -value: "NTUC" -options: ""
#     * Comm: Store -value: "#{faker.custom.person.birthDate()}" in -variable: "birthDate" -options: ""
#     * Comm: Wait for milliseconds -seconds: "5000"
#     # * Comm: Wait for milliseconds -seconds: "5000"
#     # * D365CRM: Click tab -field: "Administration" -options: ""
#     #* D365CRM: Select dropdown -fieldName: "Residential Status" -value: "PERMANENT RESIDENT" -options: ""
#     # * Comm: Wait for milliseconds -seconds: "2000"
#     # * D365CRM: Select dropdown multiple -field: "Residential Status" -text: "SINGAPORE CITIZEN,S PASS" -options: ""
#     # * Comm: Wait for milliseconds -seconds: "7000"
#     # * D365CRM: Select by index -field: "Residential Status" -index: "3" -options: ""
#     # * Comm: Wait for milliseconds -seconds: "7000"
#     # * D365CRM: Wait and verify header -text: "Membership Card" -options: ""

#     Examples: { "dataFile": "test-data/athena.xlsx", "filter": "_ENV==\"UAT\" && _STATUS==true" }

#   @athena_existing
#   Scenario: Test Athena Portal - Existing Record
#     * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
#     * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: "{ignoreCase: 'true'}"
#     * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
#     * D365CRM: Wait and verify header -text: "List of Active Applications" -options: ""
#     # * D365CRM: Input text -fieldName: "Ask about data in this table." -text: "Wong Rui waRrh" -options: ""
#     # * Web: Press Key -key: "Enter" -options: ""
#     * D365CRM: Table input filter -field: "Ask about data in this table." -text: "Wong Rui waRrh" -options: ""
#     * D365CRM: Wait for loader to disappear -field: "" -options: ""
#     * D365CRM: Click link with text -field: "Wong Rui waRrh" -options: ""
#     # * D365CRM: Input lookup -field: "Nationality" -text: "SINGAPORE CITIZEN" -options: "{inputLookupText: 'By-Clearing-Value'}"
#     * Comm: Wait for milliseconds -seconds: "5000"
#     # * D365CRM: Click top menu buttons -field: "Actions More Commands. Actions" and then sub menu -field:"Validate Eligibility" -options: ""
#     * Comm: Wait for milliseconds -seconds: "5000"
#     * D365CRM: Wait and verify header -text: "Membership Card" -options: ""
#     * D365CRM: Verify field is locked -field: "Search Id" -options: ""
#     * D365CRM: Verify input date -field: "Date of Birth" -value: "18/6/1984" -options: ""
#     * D365CRM: Verify select field value -field: "Residential Status" -value: "PERMANENT RESIDENT" -options: ""
#     * D365CRM: Verify input lookup field value -field: "Occupation Group" -value: "EMPLOYED – MANAGER" -options: ""
#     * D365CRM: Verify select list does not have given value -field: "Residential Status" -value: "PERMANENT" -options: ""
#     * D365CRM: Store input value in variable -field: "Full Name" -variableName: "MembershipCategory" -options: ""
#     * Comm: Attach log -message: "#{MembershipCategory}" -mimeType: "text/plain" -msgType: "verification"
#     * D365CRM: Store header title in form page to variable -field: "header_title" -variableName: "headerTitle" -options: ""
#     * Comm: Attach log -message: "#{headerTitle}" -mimeType: "text/plain" -msgType: "verification"

#   @test_file_upload
#   Scenario: File Upload
#     * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
#     * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: ""
#     * D365CRM: Click left menu -field: "Common" then sub menu -field: "Data Imports" -options: ""
#     * D365CRM: Wait and verify header -text: "Active Data Imports" -options: ""
#     * D365CRM: Click button -text: "New" -options: ""
#     * D365CRM: Input text -fieldName: "Name" -text: "#{faker.person.fullName()}" -options: ""
#     * D365CRM: Select dropdown -fieldName: "Module" -value: "Person" -options: ""
#     * D365CRM: Select dropdown -fieldName: "Entity" -value: "Person" -options: ""
#     * D365CRM: Click top menu button -field: "Save (CTRL+S)" -options: ""
#     * D365CRM: Upload file at -field: "Add an attachment" with filename: "CVP Utilization Per-MemberTemplate.xlsx" -options: ""
#     * Comm: Wait for milliseconds -seconds: "15000"
#     * D365CRM: Logout from Dynamics -options: ""

#   @athena_existing_edit_filter
#   Scenario: Test Athena Portal - Existing Record
#     * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
#     * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: "{ignoreCase: 'true'}"
#     # * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Memberships" -options: ""
#     # * D365CRM: Wait and verify header -text: "Union Memberships" -options: ""
#     # * D365CRM: Table input filter -field: "Ask about data in this table." -text: "Wong Shu Ghhry" -options: ""
#     # * D365CRM: Wait for loader to disappear -field: "" -options: ""
#     # * D365CRM: Table edit filter delete all and input new filters -filters: "['Application Status','Contains','IN-PROGRESS'],['Application Status','Contains','IN-PROGRESS']" -options: ""
#     # * D365CRM: Table edit filter reset to default -options: ""
#     # * Comm: Wait for milliseconds -seconds: "2000"
#     # * D365CRM: Table header scroll to column -columnNumber: "11" -options: ""
#     # * Comm: Wait for milliseconds -seconds: "3000"
#     # * D365CRM: Table header scroll to column -columnNumber: "11" -options: "{scroll: 'left'}"
#     # * Comm: Wait for milliseconds -seconds: "3000"
#     # * D365CRM: Table click header -field:"Full Name (as per NRIC)" with coloumn -column:"2" then click dropdown button -text:"A to Z" -options: ""
#     # * D365CRM: Verify table header column is in ascending order -field: "Full Name (as per NRIC)" with column -column: "2" -options: ""
#     # * D365CRM: Table click header -field:"Full Name (as per NRIC)" with coloumn -column:"2" then click dropdown button -text:"Z to A" -options: ""
#     # * D365CRM: Verify table header column is in descending order -field: "Membership Tenure (Person)" with column -column: "2" -options: ""
#     # * Comm: Wait for milliseconds -seconds: "3000"
#     # * D365CRM: Double click table cell with row -row: "" and column -column: "2" -options: ""
#     # * Comm: Wait for milliseconds -seconds: "10000"
#     # * D365CRM: Table select or deselect row -row:"15" -options: ""
#     # * D365CRM: Table select or deselect all rows -options: ""
#     # * D365CRM: Verify header control list -field: "Exchange ID" -options: ""
#     # * D365CRM: Store header control list column value -field: "1" to variable -variableName: "exchangeID" -options: ""
#     # * D365CRM: Verify table header text -field:"Created On" with column -column:"12" -options: ""
#     # * D365CRM: Verify table header all text -field:"Full Name (as per NRIC);Membership Tenure (Person);Tenure Category (Person);Union Code;Company;Branch Code;Joined Union Date;Membership Status;Membership Type;Created On;Created By" -options: ""
#     # * D365CRM: Verify table header by edit column text -field:"Branch Code" -options: ""
#     # * D365CRM: Verify table header all by edit column text -field:"Full Name (as per NRIC);Membership Tenure (Person);Tenure Category (Person);Union Code;Company;Branch Code;Joined Union Date;Membership Status;Membership Type;Created On;Created By" -options: ""
#     # * D365CRM: Assign table cell text to variable -row:"2" -column:"10" -variable:"membershipType" -options: ""
#     # * Comm: Attach-Log -message: "Membership Type is #{membershipType}" -mimeType: "text/plain" -msgType: "verification"
#     # * D365CRM: Store table row count to variable -variableName:"membershipsRowCount" -options: ""
#     # * Comm: Attach-Log -message: "Memberships Row Count is #{membershipsRowCount}" -mimeType: "text/plain" -msgType: "verification"
#     * D365CRM: Switch app from -field:"NTUC ATHENA" to -field:"Batch Jobs Administration" -options: ""
#     * Comm: Wait for milliseconds -seconds: "5000"

  @test_athena_null
  Scenario Outline: Test Athena Portal - Input Member Information
    * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena.url}" -username: "#{env.athena.user.id}" -password: "#{env.athena.user.password}" -options: ""
    * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: "{partialMatch: true}"
    * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Membership Applications" -options: ""
    * Comm: Wait for milliseconds -seconds: "10000"
    * D365CRM: Click top menu button -field: "New" -options: ""
    * D365CRM: Wait and verify header -text: "New Membership Application" -options: "{partialMatch: true}"
    * Comm: Store -value: "#{faker.custom.nric.generate({ prefix: 'S', yearOfBirth: 1985 })}" in -variable: "var.NRIC" -options: ""
    * D365CRM: Input text -fieldName: "NRIC/FIN" -text: "#{var.NRIC}" -options: ""
    * D365CRM: Input text -fieldName: "Full Name (as per NRIC)" -text: "<Full_Name>" -options: ""

    Examples: { "dataFile": "test-data/ntuc.xlsx","filter": "_ID===\"SC01\" && _STATUS===true" }

#   @test_excel_data
#   Scenario Outline: Test Athena Portal - Verify Delayed Deduction Details
#     * D365CRM: Login using Microsoft SSO -sessionName: "" -url: "#{env.athena_url}" -username: "#{env.athena_user_msdpt1}" -password: "#{env.athena_password_msdpt1}" -options: ""
#     * D365CRM: Wait and verify header -text: "Dashboard Notification" -options: "{partialMatch: true}"
#     # * D365CRM: Click left menu -field: "Membership Management" then sub menu -field: "Memberships" -options: ""
#     # * D365CRM: Wait and verify header -text: "Union Memberships" -options: ""
#     # * D365CRM: Click main system view -field:"Union Memberships" then sub system view -field:"All Memberships" -options: ""
#     # * D365CRM: Wait and verify header -text: "All Memberships" -options: ""
#     # * D365CRM: Table edit filter delete all and input new filters -filters: "['Membership Status','Equals','ACTIVE'],['Full Name (as per NRIC)','Equals','<Full_Name>']" -options: ""
#     # * D365CRM: Wait for loader to disappear -field: "Loading" -options: ""
#     # * D365CRM: Click link with text -field: "<Full_Name>" -options: ""
#     # * D365CRM: Wait and verify header -text: "<Full_Name>" -options: "{partialMatch:true}"
#     # * D365CRM: Click tab -field: "Membership Details" -options: ""
#     # * Web: Scroll to element -field: "Delayed Deduction Details" -options: "{pattern: 'd365crm',fieldType:'header'}"
#     # * D365CRM: Verify input field value -field: "Delayed Deduction" -value: "<Delayed_Deduction_Flag>" -options: ""
#     # * D365CRM: Verify input field value -field: "Delayed Deduction Type" -value: "<Delayed_Deduction_Type>" -options: ""

#     Examples: { "dataFile": "test-data/ntuc.xlsx","filter": "_ID===\"SC01\" && _STATUS===true" }

@test_API
  Scenario Outline: Test API
  * Comm: Store -value: "<Case_Number>" in -variable: "var.CaseNumber" -options: ""
  * Api: Call api -action: "changeDateTransfer" -config: "changeDateTransferCase" -baseUrl: "#{env.api.athena.change.date.transfercase.baseUrl}" -options: ""
  * Api: Assert api path value -path: "updateTransferCaseResult.message" -expected: "Case updated successfully." -options: ""

    Examples: { "dataFile": "test-data/ntuc.xlsx","filter": "_ID===\"SC01\" && _STATUS===true" }

@test_data
  Scenario Outline: Test API
  * Comm: Write-Data-To-Cell -filePath: "test-data/ntuc.xlsx" -sheetName: "CasesOrRequests" -rowId: "SC01" -data: "Case_Number:'12345'"

    Examples: { "dataFile": "test-data/ntuc.xlsx","filter": "_ID===\"SC01\" && _STATUS===true" }