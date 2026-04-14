/**
 * PlayQ Example: web.click
 *
 * Purpose: Click any element resolved via PatternIQ or raw locator.
 * Page: See 'url' constant.
 * PatternIQ: Use appropriate fieldType (e.g., 'link', 'button', 'input').
 * Steps:
 * - Open page
 * - Resolve element
 * - Click the element
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/dynamic_controls';

test('Mouse: click alias works on Remove', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.click(page, 'Remove', { pattern: 'theinternet' });
});
