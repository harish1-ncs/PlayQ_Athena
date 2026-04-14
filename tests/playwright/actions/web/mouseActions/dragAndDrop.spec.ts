/**
 * PlayQ Example: web.dragAndDrop
 *
 * Purpose: Drag element from source to target using PatternIQ-resolved locators.
 * Page: The Internet → /drag_and_drop
 * PatternIQ: pattern 'theinternet', fieldType 'column' (ids 'column-a' → 'column-b')
 * Steps:
 * - Open page
 * - Resolve source/target via PatternIQ field type 'column'
 * - Perform drag and drop
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/drag_and_drop';

test('Mouse: dragAndDrop column A to column B', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.dragAndDrop(page, 'column-a', 'column-b', { pattern: 'theinternet', fieldType: 'column' });
});
