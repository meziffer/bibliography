@echo off
setlocal

REM === Configuration ===
set BIB_FILE=scibib.bib
set COMMIT_MSG=Update bibliography

REM Move to this script's directory
cd /d "%~dp0"

REM Check bib file exists
if not exist "%BIB_FILE%" (
  echo ERROR: %BIB_FILE% not found.
  echo Make sure Zotero auto-export is saving to this folder.
  pause
  exit /b 1
)

REM Check git repo
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo ERROR: This folder is not a Git repository.
  pause
  exit /b 1
)

REM Stage bib file
git add "%BIB_FILE%"

REM Check if anything changed
git diff --cached --quiet
if not errorlevel 1 (
  echo No bibliography changes to commit.
  pause
  exit /b 0
)

REM Commit and push
git commit -m "%COMMIT_MSG%"
git push

echo Bibliography updated and pushed successfully.
pause
