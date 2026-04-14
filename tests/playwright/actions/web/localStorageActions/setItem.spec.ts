/**
 * PlayQ Example: web.setItem (localStorage)
 *
 * Purpose: Store a key/value pair in window.localStorage.
 * Page: See 'url' constant.
 * PatternIQ: Not applicable.
 * Steps:
 * - Open page
 * - Set a key/value via web.setItem
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('LocalStorage: setItem stores value', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.setItem(page, 'foo', 'bar');
  const val = await web.getItem(page, 'foo');
  expect(val).toBe('bar');
});
