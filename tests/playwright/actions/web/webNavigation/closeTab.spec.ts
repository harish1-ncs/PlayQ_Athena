/**
 * Example: web.closeTab
 *
 * Purpose: Closes the current tab and verifies it is closed.
 * Site: letcode.in
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in';

test('Close current tab', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.closeTab(page, { screenshot: false });
  expect(page.isClosed()).toBeTruthy();
});
