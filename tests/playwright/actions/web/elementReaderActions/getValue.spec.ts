/**
 * Example: web.getValue
 *
 * Purpose: Reads the current input value of an element.
 * Site: letcode.in/elements
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/elements';

test('Read value from username input after fill', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.fill(page, 'username', 'octocat', { fieldType: 'input', pattern: 'letcodesamples' });
  const value = await web.getValue(page, 'username', { fieldType: 'input', pattern: 'letcodesamples' });
  expect(value).toBe('octocat');
});
