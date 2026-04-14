/**
 * PlayQ Example: web.switchTab
 *
 * Purpose: Switch to another browser tab/window.
 * Steps:
 * - Ensure a second tab is opened
 * - Call web.switchTab to focus the target tab
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const base = 'https://letcode.in';

test('Switch between tabs', async ({ page }) => {
  // Keep first tab on /forms
  await web.openBrowser(page, base + '/forms');

  // Open second tab on /radio within the same context
  const second = await web.openNewTab(page, base + '/radio');

  // Bring first tab to front (index 0) and assert its URL
  await web.switchTab(page, 0);
  await web.waitForUrl(page, '/forms', { match: 'contains' });
  expect(page.url()).toContain('/forms');

  // Bring second tab to front (index 1); assert using 'second' page instance
  await web.switchTab(page, 1);
  await web.waitForUrl(second, '/radio', { match: 'contains' });
  expect(second.url()).toContain('/radio');
});
