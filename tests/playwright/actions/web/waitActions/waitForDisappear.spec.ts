/**
 * PlayQ Example: web.waitForDisappear
 *
 * Purpose: Wait until an element disappears from the page.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType } when resolving named elements.
 * Steps:
 * - Open page
 * - Trigger element to disappear
 * - Wait for disappearance
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/dynamic_controls';

test('Wait for checkbox to disappear', async ({ page }) => {
  await web.openBrowser(page, url);

  // Click Remove button
  await web.clickButton(page, 'Remove', { type: 'button', pattern: 'theinternet' });

  // Wait for checkbox to disappear
  await web.waitForDisappear(page, 'Remove', {
    fieldType: 'button',
    pattern: 'theinternet',
    actionTimeout: 15000
  });
});
