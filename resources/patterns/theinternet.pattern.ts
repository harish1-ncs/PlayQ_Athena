// Patterns for the-internet.herokuapp.com demo site
// Only CSS and XPath selectors supported

export const theinternet = {
  fields: {
    input: [
      "//input[@placeholder='#{loc.auto.fieldName}']",
      "//input[@id='#{loc.auto.forId}']",
      "//input[@name='#{loc.auto.fieldName}']",
      "//textarea[@name='#{loc.auto.fieldName}']",
      "//input[translate(@type,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')='text']"
    ],
    link: [
      "//a[normalize-space(.)='#{loc.auto.fieldName}']",
      "//a//span[normalize-space(.)='#{loc.auto.fieldName}']"
    ],
    button: [
      "//button[normalize-space(.)='#{loc.auto.fieldName}']",
      "//*[@role='button' and normalize-space(.)='#{loc.auto.fieldName}']",
      "//input[@type='submit' and @value='#{loc.auto.fieldName}']"
    ],
    radio: [
      "//label[normalize-space(.)='#{loc.auto.fieldName}']/preceding-sibling::input[@type='radio']",
      "//input[@type='radio' and @value='#{loc.auto.fieldName}']"
    ],
    checkbox: [
      "//label[normalize-space(.)='#{loc.auto.fieldName}']/preceding-sibling::input[@type='checkbox']",
      "//input[@type='checkbox' and @name='#{loc.auto.fieldName}']"
    ],
    dropdown: [
      "//select[@id='#{loc.auto.forId}']",
      "//select[@name='#{loc.auto.fieldName}']"
    ],
    tab: [
    ],
    header: [
      "//h1[normalize-space(.)='#{loc.auto.fieldName}']",
      "//h2[normalize-space(.)='#{loc.auto.fieldName}']",
      "//h3[normalize-space(.)='#{loc.auto.fieldName}']",
      "//*[@role='heading' and normalize-space(.)='#{loc.auto.fieldName}']",
      "//*[@role='heading' and contains(normalize-space(.),'#{loc.auto.fieldName}')]"
    ],
    column: [
      "//*[@id='#{loc.auto.fieldName}']",
    ],
    text: [
      "//p[@id='#{loc.auto.fieldName}']",
      "//p[normalize-space(text())='#{loc.auto.fieldName}']",
    ],
    frames: [
      "//iframe[@id='#{loc.auto.fieldName}']",
      "//iframe[@name='#{loc.auto.fieldName}']",
      "//iframe[@title='#{loc.auto.fieldName}']",
      "//iframe[contains(@src,'#{loc.auto.fieldName}')]",
      "//iframe"
    ],
  },
  locations: {
    top_menu: "#content",
  },
  sections: {
    radio_group: "//form//fieldset[legend[normalize-space(text())='#{loc.auto.section.value}']]",
    accordion: "//button[contains(@class,'accordion')][normalize-space(text())='#{loc.auto.section.value}']",
  },
  scroll: [
    "h1:first-child"
  ]
};
