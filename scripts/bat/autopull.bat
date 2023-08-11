@echo off
setlocal

echo ====== start pull ======

REM Change directory to your Git repository's root folder
cd /d "D:\path\project"

REM Ensure you are on the desired branch
set branch=main
git checkout %branch%

REM Pull changes from the remote repository
git pull gitlab %branch%

echo Changes pulled successfully!

endlocal

