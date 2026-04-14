// import { test as base } from '@playwright/test';

// ****************** Only CSS and XPATH locators are supported ************************

/* 
loc.auto.fieldName
loc.auto.forId
loc.auto.fieldInstance
loc.auto.location.value
loc.auto.section.value
*/

export const d365CrmLocPatterns = {
  fields: {
    label: [
      "//label[text()='#{loc.auto.fieldName}']",
    ],
    dropdown: [
      "(//button[@role='combobox'][@aria-label='#{loc.auto.fieldName}'])[#{loc.auto.fieldInstance}]",
      "//button[@role='combobox'][@aria-label='#{loc.auto.fieldName}']",
      "//select[@aria-label='#{loc.auto.fieldName}']",
      "//select[@aria-label='#{loc.auto.fieldName}'][@title='#{loc.auto.fieldInstance}']",
      "//select[@aria-label='#{loc.auto.fieldName}']//option[text()='#{loc.auto.fieldInstance}']",
      "//div[text()='#{loc.auto.fieldName}']",

    ],
    input: [
      "input[id='#{loc.auto.forId}']",
      "input[id='#{loc.auto.fieldName}']",
      "input[aria-label='#{loc.auto.field}']",
      "input[placeholder='#{loc.auto.fieldName}']",
      "input[name='#{loc.auto.fieldName}']",
      "//textarea[@aria-label='#{loc.auto.fieldName}']",
      "//label[text()='#{loc.auto.fieldName}']//..//..//textarea",
      "//input[@aria-label='Date of #{loc.auto.fieldName}']",
      "//input[@aria-label='Time of #{loc.auto.fieldName}']",
      "//input[@aria-label='#{loc.auto.fieldName}, Lookup']",
      "//div[@aria-label='#{loc.auto.fieldName}, Lookup']",
      "//input[contains(@aria-label,'#{loc.auto.fieldName}')]",
      "//input[contains(@placeholder,'#{loc.auto.fieldName}')]",
      "//input[contains(@name,'#{loc.auto.fieldName}')]",
      "//input[contains(@placeholder,'#{loc.auto.fieldName}') or contains(@aria-label,'#{loc.auto.fieldName}')]",
      "//ul[@title='#{loc.auto.fieldName}']",
      "//input[@aria-label='#{loc.auto.fieldName}']",
      "//div[@title='#{loc.auto.fieldName}']/following-sibling::div",
      "input[data-id='#{loc.auto.field}']",
      "//div[@data-id='#{loc.auto.field}']"

    ],
    link: [
      "//a[text()='#{loc.auto.fieldName}']",
      "a[href='#{loc.auto.location.value}']",
      "a[title='#{loc.auto.fieldName}']",
      "a[aria-label='#{loc.auto.fieldName}']",
      "//span[text()='#{loc.auto.fieldName}']",
      "//label[text()='#{loc.auto.fieldName}']",
      "//DIV[text()='#{loc.auto.fieldName}']/parent::DIV/UL/LI/DIV/DIV",
      "//DIV[text()='#{loc.auto.fieldName}, Readonly']/parent::DIV/UL/LI/DIV/DIV",
      "//DIV[text()='#{loc.auto.fieldName}']",
      "//li[title='#{loc.auto.fieldName}']",
      "//li[aria-label='#{loc.auto.fieldName}']",
      "//div[aria-label='#{loc.auto.fieldName}']",
      "//a[contains(text(),'#{loc.auto.fieldName}')]",
      "//a[contains(@aria-label,'#{loc.auto.fieldName}')]",
      "//a[contains(@title,'#{loc.auto.fieldName}')]",
      "//a[contains(@href,'#{loc.auto.fieldName}')]",
      "//a[contains(@aria-label,'#{loc.auto.fieldName}')]",
      "//li[contains(@aria-label,'#{loc.auto.fieldName},')]",
      "//li[contains(@aria-label,'#{loc.auto.fieldName}')]",
    ],
    button: [
      "input[type='submit'][value='#{loc.auto.fieldName}']",
      "button[value='#{loc.auto.fieldName}']",
      "button[aria-label='#{loc.auto.fieldName}']",
      "button[title='#{loc.auto.fieldName}']",
      "//button[name='#{loc.auto.fieldName}']",
      "//button[text()='#{loc.auto.fieldName}']",
      "//button//span[text()='#{loc.auto.fieldName}']",
      "//button//label[text()='#{loc.auto.fieldName}']",
      "//input[@type='submit' and @value='#{loc.auto.fieldName}']",
      "//span[@class='submit' and text()='#{loc.auto.fieldName}']",
      "//span[@class='submit' and contains(text(),'#{loc.auto.fieldName}')]",
      "//span[@id='submitButton' and text()='#{loc.auto.fieldName}']",
      "//button[contains(@aria-label,'#{loc.auto.fieldName}')]",
      "//button[contains(@title,'#{loc.auto.fieldName}')]",
      "//button[contains(text(),'#{loc.auto.fieldName}')]",
      "//button[contains(@value,'#{loc.auto.fieldName}')]",
      "//input[@type='submit' and contains(@value,'#{loc.auto.fieldName}')]",
      "//input[@type='submit' and contains(@aria-label,'#{loc.auto.fieldName}')]",
      "//input[@type='submit' and contains(@title,'#{loc.auto.fieldName}')]",
      "//div[@data-type='app-title' and @title='#{loc.auto.fieldName}']",
      "//input[@aria-label='#{loc.auto.fieldName}, Lookup']",
      "//button[contains(@data-id,'#{loc.auto.fieldName}') and starts-with(@aria-label,'Delete')]",
      "//div[contains(@id,'#{loc.auto.fieldName}')]",
      "//button[@id='#{loc.auto.fieldName}']",
      "//button[@role='option']//span[text()='#{loc.auto.fieldName}']",
      "//input[@aria-label='#{loc.auto.fieldName}']",
      "//td[contains(.,'#{loc.auto.fieldName}')]",
      "button[contains(.,'#{loc.auto.fieldName}')]",
      "//button[@onclick='#{loc.auto.fieldName}']",
      "//button/div[@role ='presentation' and contains(.,'#{loc.auto.fieldName}')]"
    ],
    header: [
      "//div[@role='heading' and text()='#{loc.auto.fieldName}']",
      "//h1[text()='#{loc.auto.fieldName}']",
      "//h1//span[text()='#{loc.auto.fieldName}']",
      "//h2[text()='#{loc.auto.fieldName}']",
      "//h3[text()='#{loc.auto.fieldName}']",
      "//div[@role='heading' and contains(text(),'#{loc.auto.fieldName}')]",
      "//li[@aria-label='#{loc.auto.fieldName}']",
      "//li[contains(@aria-label,'#{loc.auto.fieldName}')]",
      "//h1[@data-id='#{loc.auto.fieldName}']",
      "//*[contains(@id,'headerControlsList')]/div/div[1]/div[contains(.,'#{loc.auto.fieldName}')]",
      "//*[contains(@id,'#{loc.auto.fieldName}')]/div[1]/div[1]/div"
    ],
    text: [
      "//div[text()='#{loc.auto.fieldName}']",
      "//span[text()='#{loc.auto.fieldName}']",
      "//p[text()='#{loc.auto.fieldName}']",
      "//div[contains(text(),'#{loc.auto.fieldName}')]",
      "//span[contains(text(),'#{loc.auto.fieldName}')]",
      "//p[contains(text(),'#{loc.auto.fieldName}')]",
      "//label[text()='#{loc.auto.fieldName}']"
    ],
    tab: [
      "//li[@aria-label='#{loc.auto.fieldName}']",
      "//li[contains(@aria-label,'#{loc.auto.fieldName}')]"
    ],
    locked: [
      "//div[@aria-label='Locked #{loc.auto.fieldName}']",
      "//input[@aria-label='Locked #{loc.auto.fieldName}]"
    ],
    mandatory: [
      "//label[text()='#{loc.auto.fieldName}']//..//..//following-sibling::div/div[text()='*']",
      "//label[text()='#{loc.auto.fieldName}']/following-sibling::span[text()='*']"
    ],
    secured: [
      "//div[@aria-label='Secured #{loc.auto.fieldName}']"
    ],
    loader: [
      /**
       * "//span[@role='alert']",
      "//div[@id='datasethost-progress-indicator']",
      "//span[@title='Loading']"
       */
      "//span[@role='#{loc.auto.fieldName}']",
      "//div[@id='#{loc.auto.fieldName}']",
      "//span[@title='#{loc.auto.fieldName}']",
      "//div[@role='#{loc.auto.fieldName}']"
    ],
    table_column: [
      "//div[@aria-colindex='#{loc.auto.fieldName}']",
      "//div[@role='none' and text()='#{loc.auto.fieldName}']",
      "//span[text()='#{loc.auto.fieldName}']"
    ],
    table_header_edit_column: [
      "//div[@role='listitem' and @aria-label='#{loc.auto.fieldName}']",
    ],
    table_row_count: [
      "//span[contains(@class,'#{loc.auto.fieldName}')]"
    ],
    header_control_list_value: [
      "//div[@data-preview_orientation='column'][#{loc.auto.fieldName}]/div/div"
    ],
    iframe:[
      "//iframe[@id='#{loc.auto.fieldName}']",
      "//iframe[normalize-space()='#{loc.auto.fieldName}']"
    ]
  },
  locations: {
    quick_create: "//section[@data-id='quickcreateroot']",
    lookup_records: "//section[@data-id='lookupdialogroot']",
    dialog_window: "//div[@role='dialog']",
    main: "//div[@id='mainContent']",
    popup_dialog: "//div[@data-id='alertdialog' or @data-id='confirmdialog' or @role='dialog']",
    top_bar: "//div[@id='topBar']",
    top_bar_notification: "//div[contains(@id,'barnotificationlist')]",
    table_edit_filter: "//div[contains(@class,'ms-Panel-contentInner')]",
    nav_left: "//div[@role='navigation'][@data-id='navbar-container']",
    switch_app: "//div[@id='applandingpagecontentcontainer']",
    dropdown_list: "//div[@aria-label='Dropdown panel']",
    dropdown_listbox: "//div[@role='listbox']",
    dropdown_menu: "//ul[@role='menu']",
    dropdown_table_edit_filter_menu: "//div[contains(@class,'ms-Callout-container')]",
    dropdown_table_column: "//div[contains(@class,'ms-ContextualMenu-container')]",
    dropdown_tab: "//div[@role='menu']",
    dropdown_more_commands: "//div[contains(@id,'overflowbutton')]",
    dropdown_system_view: "//div[@aria-label='View Options'][@role='dialog']",
    tab: "//ul[@role='tablist']",
  },
  sections: {
    tab_list: "//li[@aria-label='#{loc.auto.section.value}']",
    input_lookup: "//input[@aria-label='<field_name>, Lookup']",
    table: "//div[contains(@class,'ag-root-wrapper-body')]",
    table_header: "//div[contains(@class,'ag-header-container')]//div[@aria-rowindex='1']",
    table_rows: `//div[contains(@class,'ag-root-wrapper-body')]//div[@aria-rowindex='#{loc.auto.section.value}']`,
    header_control_list: "//div[contains(@id,'headerControlsList')]",
    table_column_sort: "//div[contains(@class,'ag-root-wrapper-body')]//div[@aria-rowindex='1']//div[@aria-sort='#{loc.auto.section.value}']",
  },
  scroll: [
    "//div[@section='#{loc.auto.section.value}']",
    "//li[@data-type='control_fullname']"
  ],

};