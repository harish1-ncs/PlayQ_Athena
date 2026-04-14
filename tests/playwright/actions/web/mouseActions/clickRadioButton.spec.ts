/**
 * PlayQ Example: web.clickRadioButton
 *
 * Purpose: Select a radio option via associated label or value.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType: 'radio' } to resolve radios.
 * Steps:
 * - Open page
 * - Resolve radio by label/value
 * - Click the radio
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/radio';

test('Mouse: clickRadioButton Going', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.clickRadioButton(page, 'Going', { pattern: 'letcodesamples' });
});
