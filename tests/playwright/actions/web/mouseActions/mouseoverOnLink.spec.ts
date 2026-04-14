/**
 * PlayQ Example: web.mouseoverOnLink
 *
 * Purpose: Hover over a link resolved via PatternIQ or locator.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType: 'link' } when hovering by text.
 * Steps:
 * - Open page
 * - Resolve link
 * - Mouse over
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('Mouse: mouseover on footer link', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.mouseoverOnLink(page, 'Elemental Selenium', { pattern: 'theinternet', screenshot: false });
});
