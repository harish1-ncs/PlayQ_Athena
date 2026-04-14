/**
 * PlayQ Example: web.waitForCondition
 *
 * Purpose: Wait until a custom condition function evaluates to true.
 * PatternIQ: Not applicable.
 * Steps:
 * - Open page or set up context
 * - Provide a condition function
 * - Wait for condition to pass
 */

import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/waits';

test('Wait for condition: URL contains /waits', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.waitForCondition(page, async (p) => p.url().includes('/waits'));
  expect(page.url()).toContain('/waits');
  await web.waitForHeader(page, 'Wait', 'Wait');
});
