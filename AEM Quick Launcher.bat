@echo off
REM Batch Script
REM Script Name: AEM Quick Launcher
REM Author: Solifice
REM Last Modified Date: 12-02-2024
REM Description: Quick Launcher to start AEM in Debug mode or Normally

setlocal enabledelayedexpansion

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: USER CONFIGURATION
::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: Modifiy the values for DEBUG_PORT and JAR_PATH
:: Check the quotes after pasting the path
::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::
set "DEBUG_PORT=8000"
set "JAR_PATH=path\to\aem-author-p4502.jar"
::
::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: Advance setting for people with zip distribution of JDK
:: leave the value for JDK_PATH empty if not required
::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::
set "JDK_PATH="
::
::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set "terminal_width="
call :calculateTerminalWidth

set "line="
call :createLine "~"

echo  !line!
echo  ^| AEM Quick Launcher
echo  !line!
echo  ^| author: solifice
echo  !line!
echo.

call :setJavaPath "!JDK_PATH!"
call :checkJavaCompiler

call :isJarAvailable "!JAR_PATH!"
call :isAEMJar "!JAR_PATH!"

for %%I in ("!JAR_PATH!") do (

    set "parent_path=%%~dpI"
    set "file_name=%%~nxI"

)

call :isAlreadyRunning "java.exe", !file_name!
call :isAlreadyRunning "javaw.exe", !file_name!

echo  Note: Edit the values of AEM Quick Launcher script by opening it in a text editor and go to USER CONFIGURATION.
echo.

echo  ^Start AEM
echo  -----------
echo  [D] ^| Debug ^at Port: !DEBUG_PORT!
echo  [N] ^| Normal
echo.
echo  Press any other key to exit
echo.

set "choice="
for /f "delims=" %%x in ('xcopy /l /w "%~f0" "%~f0" 2^>nul') do if not defined choice set "choice=%%~x"
set "choice=!choice:~-1!"

if /i "!choice!"=="D" (

    call :isPortValid !DEBUG_PORT!
    call :isPortAvailable !DEBUG_PORT!

    call :delay "starting . . . "
    cd /d "!parent_path!"
    start java -Xmx4502m -Xdebug -agentlib:jdwp=transport=dt_socket,address=!DEBUG_PORT!,server=y,suspend=n -jar "!file_name!"
    goto finalEnd

)

if /i "!choice!"=="N" (

    call :delay "starting . . . "
    cd /d "!parent_path!"
    start javaw -Xmx4502m -jar "!file_name!" -gui
    goto finalEnd

)

call :delay "quitting . . . "
goto finalEnd

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:setJavaPath

if "x%~1" neq "x" (

    set "Path=!Path!;%~1"

)

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:checkJavaCompiler

where javac >nul 2>nul

if !errorlevel! neq 0 (

    echo  Java compiler is missing!
    goto end

)

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:isJarAvailable

if not exist "%~1" (

    echo  JAR was not found, check the JAR path and and try again.
    goto end

)

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:isAEMJar

jar tf "%~1" 2>nul | findstr /I /C:"/quickstart/" /C:"/static/bin/start.bat" >nul

if !errorlevel! neq 0 (

    echo  Path is not an AEM JAR file.
    goto end

)

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:isAlreadyRunning

tasklist /FI "IMAGENAME eq %~1" 2>nul | find /I "%~1" >nul

if !errorlevel! equ 0 (

    wmic process where "name='%~1'" get commandline | findstr /v "CommandLine" | findstr /C:"%~2" >nul

    if !errorlevel! equ 0 (

        echo  AEM is already running,
        echo  If you recently closed it, then try running the batch after sometime.
        goto end

    )

)

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:calculateTerminalWidth

for /F "tokens=2 delims=: " %%W in ('mode con ^| findstr /C:"Columns"') do (

    set "terminal_width=%%W"

)

set /A "terminal_width-=5"

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:createLine

for /L %%N in (1,1,!terminal_width!) do (

    set "line=!line!%~1"

)

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:delay

echo  %~1
timeout /t 1 >nul

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:isPortValid

set "validPort=true"

for /F "delims=0123456789" %%G in ("%~1") do (

    set "validPort="

)

if not defined validPort (

    echo  %~1 is an invalid port number.
    goto end

)

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:isPortAvailable

netstat -an | findstr /c:":%~1" >nul

if !errorlevel! equ 0 (

    echo  Debug Port %~1 is in use.
    goto end

)

exit /b

::--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:end
echo.
set /p "hold=-> Press any key to exit . . . "
:finalEnd
endlocal
exit
