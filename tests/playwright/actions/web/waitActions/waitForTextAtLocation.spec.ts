/**
 * PlayQ Example: web.waitForTextAtLocation
 *
 * Purpose: Wait for text at a named location or locator to match expectations.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern } to resolve named locations.
 * Steps:
 * - Open page
 * - Wait for text at location (exact/partial)
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/waits';

test('Wait for label text at location', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.waitForTextAtLocation(page, 'Accept the Alert', 'Accept the Alert', { pattern: 'letcodesamples', partialMatch: false, actionTimeout: 5000 });
});
