/**
 * PlayQ Example: web.removeItem (localStorage)
 *
 * Purpose: Remove a key from window.localStorage.
 * Page: See 'url' constant.
 * PatternIQ: Not applicable.
 * Steps:
 * - Open page
 * - Remove key via web.removeItem
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('LocalStorage: removeItem deletes key', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.setItem(page, 'rm', '1');
  await web.removeItem(page, 'rm');
  const val = await web.getItem(page, 'rm');
  expect(val).toBeNull();
});
