/**
 * PlayQ Example: web.acceptAlert
 *
 * Purpose: Trigger a native alert and accept it.
 * Page: LetCode → /alert
 * PatternIQ: Used to resolve the "Simple Alert" button (pattern 'letcodesamples').
 * Steps:
 * - Open page
 * - In parallel: call web.acceptAlert and click the "Simple Alert" button
 */
import { test } from '@playwright/test';
import { web, comm } from '@playq/core';

const url = 'https://letcode.in/alert';

test('Accept a simple alert', async ({ page }) => {
  await web.openBrowser(page, url);
  // Click the "Simple Alert" button to trigger native alert
  await Promise.all([
    web.acceptAlert(page, { screenshot: false }),
    web.clickButton(page, 'Simple Alert', { pattern: 'letcodesamples'}),
  ]);
// web.click      
// web.clickButtonAndAcceptAlert(page, 'Simple Alert', { pattern: 'letcodesamples' }),

});
