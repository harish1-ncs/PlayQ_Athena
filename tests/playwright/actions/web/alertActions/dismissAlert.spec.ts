/**
 * PlayQ Example: web.dismissAlert
 *
 * Purpose: Trigger a confirm alert and dismiss it.
 * Page: LetCode → /alert
 * PatternIQ: Used to resolve the "Confirm Alert" button (pattern 'letcodesamples').
 * Steps:
 * - Open page
 * - In parallel: call web.dismissAlert and click the "Confirm Alert" button
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/alert';

test('Dismiss a confirm alert', async ({ page }) => {
  await web.openBrowser(page, url);
  // Click the "Confirm Alert" button to trigger confirm dialog
  await Promise.all([
    web.dismissAlert(page, { screenshot: false }),
    web.clickButton(page, 'Confirm Alert', { pattern: 'letcodesamples' })
  ]);
});
