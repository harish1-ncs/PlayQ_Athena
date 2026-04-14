import { Given } from "@cucumber/cucumber";
import * as commCustomActions from "./commCustomActions";
import { webFixture } from "@src/global";
import { Page } from "@playwright/test";

// Reusing custom actions in step definitions

Given("Custom: Switches to iframe: {param} and clicks a button: {param} and then switches back to the main content", async function (iframeSelector: string, fieldName: string) {
    let page = webFixture.getCurrentPage();
    if (!page) throw new Error("Page is not initialized");    
    await commCustomActions.clickBtnInsideIframe(page, iframeSelector, fieldName);
});

Given("Custom: Switches to iframe: {param} and input -field: {param} -text: {param} and then switches back to the main content", async function (iframeSelector: string, fieldName: string, text: string) {
    let page = webFixture.getCurrentPage();
    if (!page) throw new Error("Page is not initialized"); 
    await commCustomActions.inputTextInsideIframe(page, iframeSelector, fieldName, text);
});


// clickBtnInsideIframe

// Given("Custom: Switches to iframe: {param} and clicks a button: {param} and then switches back to the main content", async function (iframeSelector: string,text: string) {
//     let page = webFixture.getCurrentPage();
//     await commCustomActions.clickBtnInsideIframe(page, iframeSelector,fieldName);
// });

Given("Custom: Switches to iframe: {param} and selects a radio button: {param} and then switches back to the main content", async function (iframeSelector: string, fieldName: string) {
    let page = webFixture.getCurrentPage();
    if (!page) throw new Error("Page is not initialized");
    await commCustomActions.selectRadiobutton(page, iframeSelector,fieldName);
});