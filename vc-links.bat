@echo off

rem  Prints a list of Visual C++ Tools links in the Windows Start menu.

setlocal

set programs=%ProgramData%\Microsoft\Windows\Start Menu\Programs
set a_visual_studio=%programs%\Visual Studio*

rem  Find path to a Visual Studio, e.g. "Visual Studio 2019".
for /d %%i in ("%a_visual_studio%") do (
  set visual_studio=%%~i
)

if not exist "%visual_studio%" (
  echo [ERR] Cannot find Visual Studio in the Start Menu.
  exit /b 1
)

set vc_tools=%visual_studio%\Visual Studio Tools\VC

if not exist "%vc_tools%" (
  echo [ERR] Cannot find Visual C++ tools in the Start Menu.
  exit /b 2
)

rem  Print Visual C++ Tools links.
for %%i in ("%vc_tools%\*.lnk") do (
  echo %%i
)

endlocal
