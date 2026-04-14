/**
 * PlayQ Example: web.hasFile
 *
 * Purpose: Verify a downloaded file exists on disk.
 * Page: LetCode → /file
 * PatternIQ: Used to resolve the "Download Text" link (pattern 'letcodesamples').
 * Steps:
 * - Open page
 * - Ensure download folder exists
 * - Download file via web.downloadFile
 * - Verify presence via web.hasFile
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';
import * as path from 'path';
import * as fs from 'fs';

const url = 'https://letcode.in/file';

test('Check file presence with hasFile', async ({ page }) => {
  await web.openBrowser(page, url);

  const downloadsRoot = path.join(process.env.PLAYQ_PROJECT_ROOT || process.cwd(), '_Temp', 'downloads');
  if (!fs.existsSync(downloadsRoot)) fs.mkdirSync(downloadsRoot, { recursive: true });
  const savedPath = await web.downloadFile(page, 'Download Text', { pattern: 'letcodesamples', targetDir: downloadsRoot });
  const suggested = path.basename(savedPath);

  const exists = await web.hasFile(downloadsRoot, suggested);
  expect(exists).toBe(true);
});
