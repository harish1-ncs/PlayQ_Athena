/**
 * Example: web.deleteCookie (cookieActions.deleteCookie)
 *
 * Purpose: Clears cookies in context (Playwright clears all; name used for reporting only).
 * Site: letcode.in (any page)
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Delete cookie (clears all in context)', async ({ page }) => {
  await web.openBrowser(page, url);
  await page.waitForLoadState('domcontentloaded');
  await web.setCookie(page, 'playq_token', 'del123', { domain: 'letcode.in', path: '/' });
  await web.deleteCookie(page, 'playq_token');
  const val = await web.getCookie(page, 'playq_token', { assert: false });
  expect(val).toBeUndefined();
});
