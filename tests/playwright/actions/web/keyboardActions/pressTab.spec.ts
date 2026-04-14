/**
 * PlayQ Example: web.pressTab
 *
 * Purpose: Send a Tab key press to move focus and validate behavior.
 * Page: See 'url' constant.
 * PatternIQ: Provide pattern and location when verifying changes.
 * Steps:
 * - Open page
 * - Call web.pressTab
 * - Verify focus or text change
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/edit';

test('Keyboard: pressTab', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.type(page, 'Enter your full Name', 'John Doe', { pattern: 'letcodesamples' });
  await web.pressTab(page, { screenshot: false });
});
