/**
 * PlayQ Example: web.setCookie
 *
 * Purpose: Add a cookie for the current page origin.
 * Page: LetCode (any page)
 * PatternIQ: Not applicable.
 * Steps:
 * - Open page
 * - Set cookie via web.setCookie
 * - Optionally read back via web.getCookie and assert
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Set a cookie for the current origin', async ({ page }) => {
  await web.openBrowser(page, url);
  await page.waitForLoadState('domcontentloaded');
  await web.setCookie(page, 'playq_token', 'abc123', { domain: 'letcode.in', path: '/', secure: false, httpOnly: false });
  const val = await web.getCookie(page, 'playq_token', { assert: true });
  expect(val).toBe('abc123');
});
