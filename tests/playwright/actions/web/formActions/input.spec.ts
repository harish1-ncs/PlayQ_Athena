/**
 * Example: web.input (alias of formActions.fillInput)
 *
 * Purpose: Demonstrates filling via the `input` alias and verifying value.
 * Site: letcode.in/forms
 * Pattern: letcodesamples
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Fill alias: input', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.input(page, 'First Name', 'J. Doe', { pattern: 'letcodesamples' });
  await web.verifyInputFieldValue(page, 'First Name', 'J. Doe', { pattern: 'letcodesamples' });
});
