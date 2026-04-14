/**
 * PlayQ Example: web.fill
 *
 * Purpose: Fill a text input and verify its value.
 * Page: LetCode → /forms
 * PatternIQ: pattern 'letcodesamples', fieldType 'input'.
 * Steps:
 * - Open page
 * - Fill input by label using PatternIQ
 * - Verify stored value
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Fill alias: fill', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.fill(page, 'First Name', 'Jane Doe', { pattern: 'letcodesamples' });
  await web.verifyInputFieldValue(page, 'First Name', 'Jane Doe', { pattern: 'letcodesamples' });
});
