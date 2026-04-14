/**
 * Example: web.hasClass
 *
 * Purpose: Checks whether an element contains a CSS class.
 * Site: letcode.in/elements
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/elements';

test('Check class on username input', async ({ page }) => {
  await web.openBrowser(page, url);
  const has = await web.hasClass(page, 'username', 'input', { fieldType: 'input', pattern: 'letcodesamples' });
  expect(has).toBe(true);
});
