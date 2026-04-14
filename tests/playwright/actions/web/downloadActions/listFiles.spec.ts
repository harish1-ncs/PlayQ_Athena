/**
 * Example: web.listFiles (downloadActions.listFiles)
 *
 * Purpose: Download a file and verify the directory listing
 *          contains the downloaded filename.
 * Site: letcode.in/file
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';
import * as path from 'path';
import * as fs from 'fs';

const url = 'https://letcode.in/file';

test('List files in download directory', async ({ page }) => {
  await web.openBrowser(page, url);

  const downloadsRoot = path.join(process.env.PLAYQ_PROJECT_ROOT || process.cwd(), '_Temp', 'downloads');
  if (!fs.existsSync(downloadsRoot)) fs.mkdirSync(downloadsRoot, { recursive: true });

  // Download Text
  {
    const savedPath = await web.downloadFile(page, 'Download Text', { pattern: 'letcodesamples', targetDir: downloadsRoot });
    expect(fs.existsSync(savedPath)).toBeTruthy();
  }

  // Download Excel
  {
    const savedPath = await web.downloadFile(page, 'Download Excel', { pattern: 'letcodesamples', targetDir: downloadsRoot });
    expect(fs.existsSync(savedPath)).toBeTruthy();
  }

  // Download Pdf
  {
    const savedPath = await web.downloadFile(page, 'Download Pdf', { pattern: 'letcodesamples', targetDir: downloadsRoot });
    expect(fs.existsSync(savedPath)).toBeTruthy();
  }

  const files = await web.listFiles(downloadsRoot);
  console.log('Downloaded files:', files);
  expect(Array.isArray(files)).toBeTruthy();
  expect(files.length).toBeGreaterThan(2);
  expect(files.some(f => f.toLowerCase().endsWith('.txt'))).toBeTruthy();
  expect(files.some(f => f.toLowerCase().endsWith('.xlsx'))).toBeTruthy();
  expect(files.some(f => f.toLowerCase().endsWith('.pdf'))).toBeTruthy();
});
