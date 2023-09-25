@Echo off
@Mode 60,20

set data.folder=null
set data.backup_folder=null
set data.errormessage=null

color 9f

:Loop
cls
echo  Backup tool *
echo    * By nickminick *
Call Button  0 2 "Select folder       " 0 5 "Select backup folder" 0 8 "Begin backup        " # Press
echo.
echo.
if %data.folder% == null (
	echo  Backup folder : Not set
)
if NOT %data.folder% == null (
	echo  Backup folder : %data.folder%
)

if %data.backup_folder% == null (
	echo  Folder to backup : Not set
)
if NOT %data.backup_folder% == null (
	echo  Folder to backup : %data.backup_folder%
)

Getinput /m %Press% /h 70

:
:: Check for the pressed button 
if %errorlevel%==1 (goto select.folder)	
if %errorlevel%==2 (goto select.folder.backup)	
if %errorlevel%==3 (goto begin.backup)	
goto Loop

:select.folder
cls
echo Enter a backup location :
set /p data.folder=">"
if NOT exist %data.folder%/ (
	set data.folder=null
	echo Folder not found
	ping localhost -n 2 >nul
	goto select.folder  
)
goto Loop

:select.folder.backup
cls
echo Enter the folder's location :
set /p data.backup_folder=">"
if NOT exist %data.backup_folder%/ (
	set data.backup_folder=null
	echo Folder not found
	ping localhost -n 2 >nul
	goto select.folder.backup  
)
goto Loop

:begin.backup
cls
echo Starting backup . . .
ping localhost -n 2 >nul
if %data.folder%        == null (
	echo [ERROR] Could not start backup
	echo [ERROR] You have not selected a backup location
	ping localhost -n 2 >nul
	goto Loop
)
if %data.backup_folder% == null (
	echo [ERROR] You have not selected a folder to backup
	ping localhost -n 2 >nul
	goto Loop	
)
ping localhost -n 2 >nul
echo Copying folder : %data.backup_folder%
ping localhost -n 2 >nul
echo Backup location : %data.folder%
ping localhost -n 2 >nul
for %%i in (%data.backup_folder%\*.*) do (
	echo [SUCCESS] Copied file : %%i
	copy "%%i" %data.folder%
	ping localhost -n 1 >nul
)
pause
goto Loop