@echo OFF
:: Windows NTx script
:: This script relies on two ini files, one for source of the backup and the other for destination of the backup
:: Then it runs robocopy to backup as many paths listed on the origin ini file to sub-folders in the destination path

 SETLOCAL EnableDelayedExpansion
 
:: Set variables and environment
 set origPath=%cd%
 set scriptpath=!cd!
 set backOrigPath=
 set backDestPath=
 set PathCount=
 set Tname=

 if not exist %scriptpath% ( goto :ERR0 )
 
 cls
 echo.
 :: We want to count how many origins we have
 
 :COUNTORIG
 if not exist !scriptpath!\BackpOrig.ini ( goto :ERR1 )
 
 for /f "eol=# usebackq delims== " %%a in (%scriptpath%\BackpOrig.ini) do (
  echo %%a
  set /a PathCount=1
  set /a PathCount+=1
  )
    
  goto :PICKDEST

:PICKDEST
if not exist !scriptpath!\BackpDest.ini ( goto :ERR2 )

 for /f "eol=# usebackq delims== " %%a in (%scriptpath%\BackpDest.ini) do (
  echo %%a
  set backDestPath=%%a
  )
  REM echo 1 %backDestPath%
  REM echo 2 !backDestPath!
 
 goto :PICKORIG

:PICKORIG
echo PICKORIG
 for /f "eol=# usebackq tokens=1,2* delims=, " %%b in (%scriptpath%\BackpOrig.ini) do (
   echo ==================================================
   echo.
   echo We are Starting Backup %%b
   echo From Path %%c
   echo.
   
   set Tname=%%b
   set backOrigPath=%%c
	  echo From !backOrigPath!
	  echo To   !backDestPath!\!Tname!
	 
   md "!backDestPath!\!Tname!"
   if not exist "!backDestPath!\!Tname!" ( goto :ERR3 )
   
    robocopy "!backOrigPath!" "!backDestPath!\!Tname!"  /MIR /W:5 /dcopy:T /log:"!backDestPath!"\CopyLog_!Tname!_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.log  
   set /a PathCount-=1
   echo #Backups Left = !PathCount!
   echo ==================================================
   )
  
 goto :END
 
 
::  This is the end header to just clear variables and exit the script.
 
:END
 pushd %origPath%
 
 set origPath=%cd%
 set scriptpath=!cd!
 set backOrigPath=
 set backDestPath=
 set PathCount=
 set Tname=

	goto :EOF

::  This is the Section for Error headers.
:ERR0
 @ echo  
  echo.
  echo Something seems wrong, !scriptpath! doesn't seem to exist
  echo.
 pause 
 goto :END
 
:ERR1
 @ echo   
  echo.
  echo Can't seem to find !scriptpath!\BackpOrig.ini
  echo.
 pause 
 goto :END

:ERR2
 @ echo    
  echo.
  echo Can't seem to find !scriptpath!\BackpDest.ini
  echo.
 pause 
 goto :END
 
:ERR3
 @ echo     
  echo.
  echo Can't seem be able to create "!backDestPath!\!Tname!"
  echo.
 pause 
 goto :END
 

:: changelog 
:: version_1.0: merged the listing of the drives with the identification
:: version_1.1: placed all of the lists in a folder called list and create if not exist
