import { webFixture } from "@playq";
import { Given, When, Then } from "@cucumber/cucumber";
import * as d365CrmActions from './d365CrmActions';


Given("D365CRM: Login using Microsoft SSO -sessionName: {param} -url: {param} -username: {param} -password: {param} -options: {param}", async function (sessionName, url, username, password, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.loginUsingMicrosoftSso(page, sessionName, url, username, password, options);
});


Given("D365CRM: Click button -text: {param} -options: {param}", async function (text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickButton(page, text, options);
});

Given("D365CRM: Click left menu -text: {param} -options: {param}", async function (text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickLeftMenu(page, text, options);
});

Given("D365CRM: Wait and verify header -text: {param} -options: {param}", async function (header, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.waitAndVerifyHeader(page, header, options);
});

Given("D365CRM: Input text -fieldName: {param} -text: {param} -options: {param}", async function (fieldName, text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.inputText(page, fieldName, text, options);
});

Given("D365CRM: Input Text with Enter key -fieldName: {param} -text: {param} -options: {param}", async function (fieldName, text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.inputTextAndPressEnter(page, fieldName, text, options);
});

Given("D365CRM: Select dropdown -fieldName: {param} -value: {param} -options: {param}", async function (fieldName, value, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.selectDropdown(page, fieldName, value, options);
});

Given("D365CRM: Verify text -text: {param} -options: {param}", async function (text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyText(page, text, options);
});

Given("D365CRM: Verify text -text: {param} on popup -options: {param}", async function (text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyTextOnPopupDialog(page, text, options);
});

Given("D365CRM: Input date into field -field: {param} -date: {param} -options: {param}", async function (fieldName, date, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.inputDate(page, fieldName, date, options);
});

Given("D365CRM: Input time into field -field: {param} -time: {param} -options: {param}", async function (fieldName, time, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.inputTime(page, fieldName, time, options);
});

Given("D365CRM: Click close window -options: {param}", async function (options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickCloseWindow(page, options);
});

Given("D365CRM: Click popup button -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickPopupButton(page, fieldName, options);
});

Given("D365CRM: Click link with text -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickLinkWithText(page, fieldName, options);
});

Given("D365CRM: Click lookup record link -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickLookupRecordLink(page, fieldName, options);
});

Given("D365CRM: Click left menu -field: {param} then sub menu -field: {string} -options: {param}", async function (fieldName, subFieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickLeftMenuAndSubMenu(page, fieldName, subFieldName, options);
});

Given("D365CRM: Click top menu button -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickTopMenuButton(page, fieldName, options);
});

Given("D365CRM: Click top menu buttons -field: {param} and then sub menu -field: {string} -options: {param}", async function (fieldName, subFieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickTopMenuButtonAndSubMenuButton(page, fieldName, subFieldName, options);
});

Given("D365CRM: Click main system view -field:{param} then sub system view -field:{param} -options: {param}", async function (fieldName, subFieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickMainAndSubSystemView(page, fieldName, subFieldName, options);
});

Given("D365CRM: Select dropdown multiple -field: {param} -text: {param} -options: {param}", async function (fieldName, text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.selectDropdownMultipleByText(page, fieldName, text, options);
});

Given("D365CRM: Input lookup -field: {param} -text: {param} -options: {param}", async function (fieldName, text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.inputLookup(page, fieldName, text, options);
});

Given("D365CRM: Click tab -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickTabText(page, fieldName, options);
});

Given("D365CRM: Select by index -field: {param} -index: {param} -options: {param}", async function (fieldName, index, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.selectDropdownByIndex(page, fieldName, index, options);
});

Given("D365CRM: Wait for new tab to be present -tab_text: {param} -options: {param}", async function (tabText, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.waitForNewTabToBePresent(page, tabText, options);
});

Given("D365CRM: Verify field is locked -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyFieldIsLocked(page, fieldName, options);
});

Given("D365CRM: Verify field is mandatory -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyFieldMandatory(page, fieldName, options);
});

Given("D365CRM: Verify field is secured -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyFieldSecured(page, fieldName, options);
});

Given("D365CRM: Verify input field value -field: {param} -value: {param} -options: {param}", async function (fieldName, value, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyInputValue(page, fieldName, value, options);
});

Given("D365CRM: Verify input date -field: {param} -value: {param} -options: {param}", async function (fieldName, value, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyInputValue(page, fieldName, value, options);
});

Given("D365CRM: Verify locked input field value -field: {param} -value: {param} -options: {param}", async function (fieldName, value, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyLockedInputValue(page, fieldName, value, options);
});

Given("D365CRM: Wait for loader to disappear -field: {param} -options: {param}", async function (fieldName,options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.waiForLoaderToDisappear(page,fieldName,options);
});

Given("D365CRM: Verify select field value -field: {param} -value: {param} -options: {param}", async function (fieldName, value, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifySelectFieldValue(page, fieldName, value, options);
});

Given("D365CRM: Verify input lookup field value -field: {param} -value: {param} -options: {param}", async function (fieldName, value, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyInputLookupText(page, fieldName, value, options);
});

Given("D365CRM: Verify select list does not have given value -field: {param} -value: {param} -options: {param}", async function (fieldName, value, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifySelectListDoesNotHaveValue(page, fieldName, value, options);
});

Given("D365CRM: Upload file at -field: {param} with filename: {param} -options: {param}", async function (fieldName, fileName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.uploadFileAt(page, fieldName, fileName, options);
});

Given("D365CRM: Logout from Dynamics -options: {param}", async function (options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.logoutFromDynamics(page, options);

});

Given("D365CRM: Store input value in variable -field: {param} -variableName: {param} -options: {param}", async function (fieldName, variableName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.storeInputValueToVariable(page, fieldName, variableName, options);
});

Given("D365CRM: Store header title in form page to variable -field: {param} -variableName: {param} -options: {param}", async function (fieldName, variableName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.storeHeaderTitleToVariable(page, fieldName, variableName, options);
});

Given("D365CRM: Table input filter -field: {param} -text: {param} -options: {param}", async function (fieldName, text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.tableInputFilter(page, fieldName, text, options);
});

Given("D365CRM: Table edit filter delete all and input new filters -filters: {param} -options: {param}", async function (filters, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.tableEditFilterDeleteAllAndInputNewFilters(page, filters, options);
});

Given("D365CRM: Table edit filter reset to default -options: {param}", async function (options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.tableEditFilterResetToDefault(page, options);
});

Given("D365CRM: Table header scroll to column -columnNumber: {param} -options: {param}", async function (colNumber, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.tableHeaderScrollToColumn(page, colNumber, options);
});

Given("D365CRM: Table click header -field: {param} with coloumn -column: {param} then click dropdown button -text: {param} -options: {param}", async function (field, column, text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.tableClickHeaderColumnThenClickDropdownButton(page, field, column, text, options);
});

Given("D365CRM: Double click table cell with row -row: {param} and column -column: {param} -options: {param}", async function (row, column, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.doubleClickTableCell(page, row, column, options);
});

Given("D365CRM: Table select or deselect row -row: {param} -options: {param}", async function (row, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.tableSelectOrDeselectRow(page, row, options);
});

Given("D365CRM: Table select or deselect all rows -options: {param}",async function (options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.tableSelectOrDeselectAllRows(page, options);
});

Given("D365CRM: Verify header control list -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyHeaderControlList(page, fieldName, options);
});

Given("D365CRM: Verify table header text -field: {param} with column -column: {param} -options: {param}", async function (fieldName, column, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyTableHeaderText(page, fieldName, column, options);
});

Given("D365CRM: Verify table header all text -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyTableHeaderAllText(page, fieldName, options);
});

Given("D365CRM: Verify table header column is in ascending order -field: {param} with column -column: {param} -options: {param}",async function(fieldName,column,options){
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyTableHeaderColumnIsInAscendingOrder(page, fieldName, column, options);
});

Given("D365CRM: Verify table header column is in descending order -field: {param} with column -column: {param} -options: {param}",async function(fieldName,column,options){
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyTableHeaderColumnIsInDescendingOrder(page, fieldName, column, options);
});

Given("D365CRM: Verify table header by edit column text -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyTableHeaderByEditColumnText(page, fieldName, options);
});

Given("D365CRM: Verify table header all by edit column text -field: {param} -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyTableHeaderAllByEditColumnText(page, fieldName, options);
});

Given("D365CRM: Verify table cell text -row: {param} -column: {param} -text: {param} -options: {param}", async function (row, column, text, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyTableCellText(page, row, column, text, options);
});

Given("D365CRM: Assign table cell text to variable -row: {param} -column: {param} -variable: {param} -options: {param}", async function (row, column, variableName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.assignTableCellTextToVariable(page, row, column, variableName, options);
});

Given("D365CRM: Store table row count to variable -variableName: {param} -options: {param}", async function (variableName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.storeTableRowCountToVariable(page, variableName, options);
});

Given("D365CRM: Store header control list column value -field: {param} to variable -variableName: {param} -options: {param}", async function (fieldName, variableName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.storeHeaderControlListColumnValueToVariable(page, fieldName, variableName, options);
});

Given("D365CRM: Switch app from -field:{param} to -field:{param} -options: {param}", async function (fromApp, toApp, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.switchApp(page, fromApp, toApp, options);
});

Given("D365CRM: Debug this step to pause execution -options: {param}", async function (options) {
  let page = webFixture.getCurrentPage();
  await page.pause();
});

Given("D365CRM: Click -field: {param} button on back date popup -options: {param}", async function (fieldName, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.clickProceedOrCancelBtnOnBackDatePopup(page, fieldName, options);
});

Given("D365CRM: Verify input field attribute value -field: {param} -variableName: {param} -expectedValue: {param} -options: {param}", async function (fieldName, variableName, expectedValue, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyInputAttributeValue(page, fieldName, variableName, expectedValue, options);
});

Given("D365CRM: Verify header control list column value -field: {param} -variableName: {param} -expectedValue: {param} -options: {param}", async function (fieldName, variableName, expectedValue, options) {
  let page = webFixture.getCurrentPage();
  await d365CrmActions.verifyHeaderControlListColumnValue(page, fieldName, variableName, expectedValue, options);
});