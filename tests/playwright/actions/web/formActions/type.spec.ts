/**
 * Example: web.type (alias of formActions.fillInput)
 *
 * Purpose: Demonstrates typing into an input and verifying its value.
 * Site: letcode.in/forms
 * Pattern: letcodesamples
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Fill alias: type', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.type(page, 'First Name', 'Jane D.', { pattern: 'letcodesamples' });
  await web.verifyInputFieldValue(page, 'First Name', 'Jane D.', { pattern: 'letcodesamples' });
});
