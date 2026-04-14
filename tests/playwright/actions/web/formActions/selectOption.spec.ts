/**
 * Example: web.selectDropdown (wrapper for formActions.selectOption)
 *
 * Purpose: Select a dropdown option by visible text.
 * Site: letcode.in/dropdowns
 * Pattern: letcodesamples (resources/patterns/letcodesamples.pattern.ts)
 */
import { test } from '@playwright/test';
import { web } from "@playq/core";

const url = "https://letcode.in/dropdowns";

test('Select dropdown option by text', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.selectDropdown(page, "fruits", "Apple", { pattern: "letcodesamples" });
});
