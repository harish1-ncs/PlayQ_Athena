/**
 * PlayQ Example: web.waitForEnabled
 *
 * Purpose: Wait until a target element becomes enabled.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType } to resolve element by name.
 * Steps:
 * - Open page
 * - Wait for enabled state
 */

import { test } from '@playwright/test';
import { web, webLocResolver } from '@playq/core';

const url = 'https://letcode.in/waits';

test('Wait for "Simple Alert" button to be enabled', async ({ page }) => {
  await web.openBrowser(page, url);
  const locator = await webLocResolver('button', 'Simple Alert', page, 'letcodesamples', 5000);
  await web.waitForEnabled(locator, 5000);
});
