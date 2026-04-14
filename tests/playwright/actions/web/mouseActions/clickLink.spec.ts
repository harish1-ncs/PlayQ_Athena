/**
 * PlayQ Example: web.clickLink
 *
 * Purpose: Click a hyperlink resolved via PatternIQ or raw locator.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType: 'link' } when using named links.
 * Steps:
 * - Open page
 * - Resolve link by text or locator
 * - Click the link
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('Mouse: clickLink A/B Testing navigates', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.clickLink(page, 'A/B Testing', { pattern: 'theinternet' });
  await web.waitForUrl(page, '/abtest', { match: 'contains' });
  expect(page.url()).toContain('/abtest');
});
