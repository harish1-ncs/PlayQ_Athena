/**
 * Example: web.clearCookies (cookieActions.clearCookies)
 *
 * Purpose: Clears all cookies in the current browser context.
 * Site: letcode.in (any page)
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Clear all cookies in context', async ({ page }) => {
  await web.openBrowser(page, url);
  await page.waitForLoadState('domcontentloaded');
  await web.setCookie(page, 'cookie_one', 'one', { domain: 'letcode.in', path: '/' });
  await web.setCookie(page, 'cookie_two', 'two', { domain: 'letcode.in', path: '/' });
  await web.clearCookies(page);
  const v1 = await web.getCookie(page, 'cookie_one', { assert: false });
  const v2 = await web.getCookie(page, 'cookie_two', { assert: false });
  expect(v1).toBeUndefined();
  expect(v2).toBeUndefined();
});
