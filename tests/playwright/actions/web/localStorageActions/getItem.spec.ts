/**
 * PlayQ Example: web.getItem (localStorage)
 *
 * Purpose: Retrieve a value previously set in window.localStorage.
 * Page: The Internet (homepage)
 * PatternIQ: Not applicable.
 * Steps:
 * - Open page
 * - Set a key/value via web.setItem
 * - Retrieve value via web.getItem with assert
 * - Verify the returned value
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('LocalStorage: getItem retrieves value', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.setItem(page, 'alpha', 'beta');
  const val = await web.getItem(page, 'alpha', { assert: true });
  expect(val).toBe('beta');
});
