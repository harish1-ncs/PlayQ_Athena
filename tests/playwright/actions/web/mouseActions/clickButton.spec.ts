/**
 * PlayQ Example: web.clickButton
 *
 * Purpose: Click a button by label using PatternIQ or locator.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType: 'button' } to resolve by text.
 * Steps:
 * - Open page
 * - Resolve button by label
 * - Click the button
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/dynamic_controls';

test('Mouse: clickButton on Remove', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.clickButton(page, 'Remove', { pattern: 'theinternet' });
});
