/**
 * Example: web.clickCheckbox
 *
 * Purpose: Demonstrates clicking a checkbox using PatternIQ resolution.
 * Site: letcode.in/radio
 * Pattern: letcodesamples (resources/patterns/letcodesamples.pattern.ts)
 */
import { test } from '@playwright/test';
import { web } from "@playq/core";

const url = "https://letcode.in/radio";

test('Checkbox selection via pattern', async ({ page }) => {
  await web.openBrowser(page, url);
  // Use a checkbox that is unchecked by default so we see the action work
  await web.clickCheckbox(page, "I agree", { pattern: "letcodesamples" });
});
