set REPOSITORY_PATH=D:\enviorment\maven_repo 
rem searching...
for /f "delims=" %%i in ('dir /b /s "%REPOSITORY_PATH%\*lastUpdated*"') do (
     del /s /q %%i
)
rem finished searching
pause
