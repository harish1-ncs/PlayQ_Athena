/**
 * Example: web.uploadFile (delegates to formActions.uploadFile)
 *
 * Purpose: Upload a local CSV via `<input type="file">` resolution.
 * Site: letcode.in/file
 * Pattern: letcodesamples (resources/patterns/letcodesamples.pattern.ts)
 * Precondition: CSV exists at PlayQ_PROJECT/test-data/lambdaTest.csv (or provide an absolute path).
 */
import { test } from '@playwright/test';
import { web, comm } from "@playq/core";

const url = "https://letcode.in/file";

test('Upload a CSV file', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.uploadFile(page, "Choose a file", "lambdaTest.csv", { pattern: "letcodesamples" });
  await comm.waitInMilliSeconds(5000);
});
