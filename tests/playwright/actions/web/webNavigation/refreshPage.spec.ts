/**
 * PlayQ Example: web.refreshPage
 *
 * Purpose: Refresh the current page.
 * Steps:
 * - Navigate to a page
 * - Call web.refreshPage
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Refresh page resets input value', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.fill(page, 'First Name', 'Temp', { fieldType: 'input', pattern: 'letcodesamples' });
  await web.refreshPage(page, { screenshot: false });
  await web.waitForPageToLoad(page);
  const value = await web.getValue(page, 'First Name', { fieldType: 'input', pattern: 'letcodesamples' });
  expect(value).toBe('');
});
