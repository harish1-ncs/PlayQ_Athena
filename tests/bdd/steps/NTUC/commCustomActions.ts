import { comm, web } from "@playq";
import { Page } from "playwright";

/**
 * Custom: Switches to the specified iframe:{param} clicks a button with the given fieldName:{param}, and then switches back to the main content.
 * @param page The Playwright page object.
 * @param iframeSelector The selector for the iframe.
 * @param fieldName The text of the button to click.
 * @throws Error if page is not initialized or alert does not appear within timeout
 */
export async function clickBtnInsideIframe(page: Page, iframeSelector: string, fieldName: string) {
    if (!page) throw new Error("Page is not initialized");
    const frame = await web.switchToFrame(page, iframeSelector, { pattern: "d365crm", fieldType: "iframe" });
    await comm.waitInMilliSeconds(2000);
    const buttonLocator = frame.locator(`//button[normalize-space(text())='${fieldName}']`);
    await buttonLocator.click();
    await web.switchToMainContent(page);
}

/**
 * Custom: Switches to the specified iframe:{param} inputs text into a field with the given fieldName:{param}, and then switches back to the main content.
 * @param page The Playwright page object.
 * @param iframeSelector The selector for the iframe.
 * @param fieldName The placeholder attribute of the input field to fill.
 * @param text The text to input into the field.
 */
export async function inputTextInsideIframe(page: Page, iframeSelector: string, fieldName: string, text: string) {
    const frame = await web.switchToFrame(page, iframeSelector, { pattern: "d365crm", fieldType: "iframe" });
    await comm.waitInMilliSeconds(2000);
    const inputLocator = frame.locator(`//input[@placeholder="${fieldName}"]`);
    await inputLocator.fill(text);
    await web.switchToMainContent(page);
}


/**
 * Custom: Switches to the specified iframe:{param} inputs text into a field with the given fieldName:{param}, and then switches back to the main content.
 * @param page The Playwright page object.
 * @param iframeSelector The selector for the iframe.
 * @param selectRadiobutton The placeholder attribute of the input field to fill.
 * @param text The text to input into the field.
 */
export async function selectRadiobutton(page: Page, iframeSelector: string, fieldName: string) {
    const frame = await web.switchToFrame(page, iframeSelector, { pattern: "d365crm", fieldType: "iframe" });
    await comm.waitInMilliSeconds(2000);
    const radiobuttonlocator = frame.locator(`//td[contains(.,'${fieldName}')]`);
    await radiobuttonlocator.click();
    await web.switchToMainContent(page);
}
