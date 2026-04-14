/**
 * PlayQ Example: web.seeAlertText
 *
 * Purpose: Verify alert text using partial and/or case-insensitive matching.
 * Page: LetCode → /alert
 * PatternIQ: Used to resolve the triggering button (pattern 'letcodesamples').
 * Steps:
 * - Open page
 * - In parallel: call web.seeAlertText and click the alert-triggering button
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/alert';

test('Verify alert text', async ({ page }) => {
  await web.openBrowser(page, url);
  // Click the "Simple Alert" button to trigger alert
  await Promise.all([
    // LetCode simple alert text: "Hey! Welcome to LetCode" → verify partial
    web.seeAlertText(page, 'Welcome to LetCode', { partialMatch: true, ignoreCase: true, assert: true, screenshot: false }),
    web.clickButton(page, 'Simple Alert', { pattern: 'letcodesamples' })
  ]);
});
