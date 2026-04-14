/**
 * PlayQ Example: validation.verifyHeaderText
 *
 * Purpose: Validate a header element’s text content.
 * PatternIQ: Provide { pattern, fieldType: 'header' } when resolving headings.
 * Steps:
 * - Navigate
 * - Validate header text matches expectation
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('Verify header text equals Welcome to the-internet', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.verifyHeaderText(page, 'Welcome to the-internet', { pattern: 'theinternet', partialMatch: false, screenshot: false });
});
