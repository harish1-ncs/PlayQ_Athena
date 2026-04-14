/**
 * Example: web.set (alias of formActions.fillInput)
 *
 * Purpose: Demonstrates setting input value via `set` alias and verifying.
 * Site: letcode.in/forms
 * Pattern: letcodesamples
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Fill alias: set', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.set(page, 'First Name', 'JD', { pattern: 'letcodesamples' });
  await web.verifyInputFieldValue(page, 'First Name', 'JD', { pattern: 'letcodesamples' });
});
