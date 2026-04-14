/**
 * Example: web.selectDropdownByIndex (wrapper for formActions.selectOptionByIndex)
 *
 * Purpose: Select a dropdown option by zero-based index.
 * Site: letcode.in/dropdowns
 * Pattern: letcodesamples (resources/patterns/letcodesamples.pattern.ts)
 */
import { test } from '@playwright/test';
import { web } from "@playq/core";

const url = "https://letcode.in/dropdowns";

test('Select dropdown option by index', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.selectDropdownByIndex(page, "superheros", 2, { pattern: "letcodesamples" });
});
