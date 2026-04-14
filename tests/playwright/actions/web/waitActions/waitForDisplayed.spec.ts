/**
 * PlayQ Example: web.waitForDisplayed
 *
 * Purpose: Wait until a target element is displayed/visible.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType } to resolve element by name.
 * Steps:
 * - Open page
 * - Wait for displayed state
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/waits';

test('Wait for "Simple Alert" button to be displayed', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.waitForDisplayed(page, 'Simple Alert', { fieldType: 'button', pattern: 'letcodesamples', screenshot: false });
});
