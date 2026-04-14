/**
 * PlayQ Example: web.pressKey
 *
 * Purpose: Send a specific key press and validate the app’s response.
 * Page: See 'url' constant.
 * PatternIQ: Provide pattern and location when waiting for text updates.
 * Steps:
 * - Open page
 * - Call web.pressKey with the desired key
 * - Validate response via waitForTextAtLocation
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/edit';

test('Keyboard: pressKey TAB', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.type(page, 'Enter your full Name', 'John Doe', { pattern: 'letcodesamples' });
  await web.pressKey(page, 'Tab', { screenshot: false });
});
