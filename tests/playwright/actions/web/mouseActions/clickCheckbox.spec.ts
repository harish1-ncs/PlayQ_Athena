/**
 * PlayQ Example: web.clickCheckbox
 *
 * Purpose: Toggle a checkbox via label association or direct locator.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType: 'checkbox' } to resolve by label.
 * Steps:
 * - Open page
 * - Resolve checkbox by label or locator
 * - Click to toggle
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Mouse: clickCheckbox ', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.clickCheckbox(page, 'I agree to the terms and conditions', { pattern: 'letcodesamples' });
});
