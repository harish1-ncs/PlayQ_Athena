/**
 * letcodesamples.pattern.ts
 * Locator pattern definitions used by webLocResolver when options.pattern = "letcodesamples".
 * Only CSS and XPath locators are supported.
 *
 * Interpolation tokens:
 * - #{loc.auto.fieldName}
 * - #{loc.auto.fieldName.toLowerCase}
 * - #{loc.auto.forId}
 * - #{loc.auto.fieldInstance}
 * - #{loc.auto.location.value}
 * - #{loc.auto.section.value}
 */

export const letcodesamples = {
  fields: {
    header: [
      "//div[@role='heading' and text()='#{loc.auto.fieldName}']",
      "//h1[text()='#{loc.auto.fieldName}']",
      "//h1//span[text()='#{loc.auto.fieldName}']",
      "//h2[text()='#{loc.auto.fieldName}']",
      "//h3[text()='#{loc.auto.fieldName}']",
      "//div[@role='heading' and contains(text(),'#{loc.auto.fieldName}')]",
    ],
    tab: [
      "//a[normalize-space(text())='#{loc.auto.fieldName}']",
    ],
    button: [
      "#home",
      "//button[normalize-space(text())='#{loc.auto.fieldName}']",
      "//button[contains(normalize-space(text()), '#{loc.auto.fieldName}')]",
      "//input[@type='button' and @value='#{loc.auto.fieldName}']",

      //***************************/
      "//button//a[normalize-space(text())='#{loc.auto.fieldName}']",
    ],
    radio: [
      "//div[@role='radiogroup']//span[text()='#{loc.auto.fieldName}']",
      "//label[@class='radio'][normalize-space(text())='#{loc.auto.fieldName}']/input"

      //***************************/
    ],
    checkbox: [
      // By label@for → input#id
      "//input[@type='checkbox' and @id=//label[translate(normalize-space(.), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='#{loc.auto.fieldName.toLowerCase}']/@for]",
      // Label followed by input
      "//label[normalize-space(text())='#{loc.auto.fieldName}']/following::input[@type='checkbox'][1]",
      // Label preceding input
      "//label[normalize-space(text())='#{loc.auto.fieldName}']/preceding::input[@type='checkbox'][1]",
      // Aria-label direct match
      "//input[@type='checkbox' and @aria-label='#{loc.auto.fieldName}']",
      // Fallback: span text adjacent to input (case-insensitive)
      "//span[translate(normalize-space(text()), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='#{loc.auto.fieldName.toLowerCase}']/preceding::input[@type='checkbox']",
      "//span[contains(normalize-space(text()),'#{loc.auto.fieldName}')]/preceding::input[@type='checkbox']",

      //***************************/
      "//label[contains(normalize-space(.),'#{loc.auto.fieldName}')]//input[@type='checkbox']"

    ],
    label: [

      "//span[normalize-space(text())='#{loc.auto.fieldName}']",
      "//label[translate(normalize-space(.), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='#{loc.auto.fieldName.toLowerCase}']",

      //***************************/
      "//label[normalize-space(text())='#{loc.auto.fieldName}']",
    ],
    link: [
      "//a[normalize-space(text())='#{loc.auto.fieldName}']",
      "//a[contains(normalize-space(text()), '#{loc.auto.fieldName}')]",

      //***************************/
    ],
    input: [
      // By associated label → following input
      "//label[normalize-space(text())='#{loc.auto.fieldName}']/following::input[1]",
      // Case-insensitive label match → following input
      "//label[translate(normalize-space(.), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='#{loc.auto.fieldName.toLowerCase}']/following::input[1]",
      // Direct id from label@for
      "//input[@id='#{loc.auto.forId}']",
      // Placeholder equals or contains field name
      "//input[@placeholder='#{loc.auto.fieldName}']",
      "//input[contains(@placeholder, '#{loc.auto.fieldName}')]",
      // aria-label equals field name
      "//input[@aria-label='#{loc.auto.fieldName}']",
      // Fallback: input near a span/label containing text
      "//span[contains(normalize-space(text()), '#{loc.auto.fieldName}')]/following::input[1]",

      //***************************/
      // name equals case-insensitive
      "//input[translate(@name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='#{loc.auto.fieldName.toLowerCase}']",
      "//input[@type='file' and @name='#{loc.auto.fieldName}']",

      "//span[contains(normalize-space(text()), '#{loc.auto.fieldName}')]/ancestor::label//input"


    ],
    dropdown: [
      // By associated label → following select
      "//label[normalize-space(text())='#{loc.auto.fieldName}']/following::select[1]",
      // Case-insensitive label → following select
      "//label[translate(normalize-space(.), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='#{loc.auto.fieldName.toLowerCase}']/following::select[1]",

      // Direct id from fieldName (supports passing explicit id like "fruits")
      "//select[@id='#{loc.auto.fieldName}']",
      // name equals case-insensitive
      "//select[translate(@name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='#{loc.auto.fieldName.toLowerCase}']",
      // aria-label equals
      "//select[@aria-label='#{loc.auto.fieldName}']",

      //***************************/
      // Direct id from label@for
      "//select[@id='#{loc.auto.forId}']",
    ],

    text: [
      "//label[normalize-space(text())='#{loc.auto.fieldName}']",
    ],
    iframe: [
      "//iframe[@id='#{loc.auto.fieldName}']",
      "//iframe[@name='#{loc.auto.fieldName}']",
      "//iframe[@title='#{loc.auto.fieldName}']",
      "//iframe[contains(@src,'#{loc.auto.fieldName}')]",
    ],
  },
  locations: {
    // Add any common containers you want to scroll into view
  },
  sections: {
    field: "//label[normalize-space(text())='#{loc.auto.section.value}']/parent::div",
    radio_group: "//fieldset[legend[normalize-space(text())='#{loc.auto.section.value}']]",
    accordion: "//button[contains(@class,'accordion')][text()='#{loc.auto.section.value}']",
  },
  // Optional scroll helpers to reveal content during pattern retries
  scroll: [
    "h1:first-child"
  ],
};
