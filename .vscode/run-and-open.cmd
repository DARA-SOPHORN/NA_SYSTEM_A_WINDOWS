@echo off
rem Run docker compose, then open the page of each service that was started.
cd /d "%~dp0.."
docker compose %*
if errorlevel 1 exit /b %errorlevel%

setlocal EnableDelayedExpansion
set "services="
set "skip=0"

:next
if "%~1"=="" goto open
set "arg=%~1"
shift
if "!skip!"=="1" (
  set "skip=0"
  goto next
)
for %%o in (-f --file -p --project-name --profile --env-file) do (
  if /i "!arg!"=="%%o" (
    set "skip=1"
    goto next
  )
)
if "!arg:~0,1!"=="-" goto next
if /i "!arg!"=="up" goto next
set "services=!services! !arg!"
goto next

:open
if "!services!"=="" set "services=admin client api"
for %%s in (!services!) do (
  if /i "%%s"=="admin" call :launch admin http://localhost
  if /i "%%s"=="client" call :launch client http://localhost:81
  if /i "%%s"=="api" call :launch api http://localhost:8000/docs
)
exit /b 0

:launch
echo Opening %1: %2
start "" "%2"
exit /b 0
