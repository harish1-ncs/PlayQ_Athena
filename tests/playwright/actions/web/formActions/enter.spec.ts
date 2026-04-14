/**
 * Example: web.enter (alias of formActions.fillInput)
 *
 * Purpose: Demonstrates entering text and verifying its value.
 * Site: letcode.in/forms
 * Pattern: letcodesamples
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Fill alias: enter', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.enter(page, 'First Name', 'Jane', { pattern: 'letcodesamples' });
  await web.verifyInputFieldValue(page, 'First Name', 'Jane', { pattern: 'letcodesamples' });
});
