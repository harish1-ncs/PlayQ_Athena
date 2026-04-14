/**
 * Example: web.getCookie (cookieActions.getCookie)
 *
 * Purpose: Retrieves the value of a cookie by name.
 * Site: letcode.in (any page)
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Get a cookie value', async ({ page }) => {
  await web.openBrowser(page, url);
  await page.waitForLoadState('domcontentloaded');
  await web.setCookie(page, 'playq_token', 'xyz789', { domain: 'letcode.in', path: '/' });
  const val = await web.getCookie(page, 'playq_token', { assert: true });
  expect(val).toBe('xyz789');
});
