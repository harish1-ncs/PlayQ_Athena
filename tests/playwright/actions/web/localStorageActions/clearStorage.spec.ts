/**
 * PlayQ Example: web.clearStorage (localStorage)
 *
 * Purpose: Clear all keys from window.localStorage.
 * Page: See 'url' constant.
 * PatternIQ: Not applicable.
 * Steps:
 * - Open page
 * - Clear storage via web.clearStorage
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('LocalStorage: clearStorage wipes all keys', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.setItem(page, 'k1', 'v1');
  await web.setItem(page, 'k2', 'v2');
  await web.clearStorage(page);
  const v1 = await web.getItem(page, 'k1');
  const v2 = await web.getItem(page, 'k2');
  expect(v1).toBeNull();
  expect(v2).toBeNull();
});
