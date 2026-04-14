/**
 * PlayQ Example: web.pressEnter
 *
 * Purpose: Send an Enter key press and validate the app’s response.
 * Page: The Internet → /key_presses
 * PatternIQ: Used by waitForTextAtLocation to resolve 'result' via pattern 'theinternet'.
 * Steps:
 * - Open page
 * - Call web.pressEnter
 * - Wait for exact text at the 'result' location via PatternIQ
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/key_presses';

test('Keyboard: pressEnter', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.pressEnter(page, { screenshot: false });
  await web.waitForTextAtLocation(page, 'result', 'You entered: ENTER', { pattern: 'theinternet', partialMatch: false, actionTimeout: 5000 });
});
