/**
 * PlayQ Example: web.clickTab
 *
 * Purpose: Click a navigation tab in the site header using PatternIQ.
 * Page: LetCode → /test
 * PatternIQ: pattern 'letcodesamples', fieldType 'tab'
 * Steps:
 * - Open the LetCode test page
 * - Resolve the "Courses" tab via PatternIQ
 * - Click the tab; screenshots optional
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/test';

test('Click Courses tab', async ({ page }) => {
  await web.openBrowser(page, url);

  await web.clickTab(page, 'Courses', {
    pattern: 'letcodesamples',
    screenshot: false
  });
});
