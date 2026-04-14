/**
 * PlayQ Example: web.fillAlert
 *
 * Purpose: Trigger a prompt alert and provide text input.
 * Page: LetCode → /alert
 * PatternIQ: Used to resolve the "Prompt Alert" button (pattern 'letcodesamples').
 * Steps:
 * - Open page
 * - In parallel: call web.fillAlert and click the "Prompt Alert" button
 */
import { test } from '@playwright/test';
import { web, comm } from '@playq/core';

const url = 'https://letcode.in/alert';

test('Fill a prompt alert', async ({ page }) => {
  await web.openBrowser(page, url);
  // Click the "Prompt Alert" button to trigger prompt dialog
  await Promise.all([
    web.fillAlert(page, 'PlayQ', { screenshot: false }),
    web.clickButton(page, 'Prompt Alert', { pattern: 'letcodesamples' }),
    comm.waitInMilliSeconds(5000)
    
  ]);
});
