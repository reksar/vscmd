@echo off

set batch_path=%~d0%~p0

rem Initializes the VS Tools CLI, e.g. for use the `cl` compiler or `msbuild` 
rem in third-party batch scripts. Like VS Tools Command Prompt from Start menu, 
rem but for scripting rather than manual use.

rem We cannot use the same VS Tools Command Prompt for this purpose, because 
rem it runs `cmd.exe` with the `/k` key, which prevents exit after the 
rem "vcvvars*.bat" is executed.

rem Instead we need to call the "vcvvars*.bat" script here.

rem VS Build Tools may be installed to a non-default path, so we use the link 
rem at the Start menu to determine the path to the `vcvars*.bat`.

rem Required arg for the vcvars suffix: "vcvars32.bat" or "vcvars64.bat".
set bits=%~1

set programs=%ProgramData%\Microsoft\Windows\Start Menu\Programs

set visual_studio=%programs%\Visual Studio*
rem Find path to any Visual Studio, e.g. "Visual Studio 2019".
for /d %%i in ("%visual_studio%") do (
  set visual_studio=%%~i
)

if not exist "%visual_studio%" (
  echo Cannot find Visual Studio in the Start Menu.
  exit /b 11
)

set vc_tools=%visual_studio%\Visual Studio Tools\VC

if not exist "%vc_tools%" (
  echo Cannot find Visual C++ tools in the Start Menu.
  exit /b 12
)

set vc_tools_lnk=%vc_tools%\*.lnk
rem Find path to any link of the Visual C++ tool.
for %%i in ("%vc_tools_lnk%") do (
  rem Set `vcvars_path` if found.
  call "%batch_path%vcvars_path.bat" "%%i"
)

if "%vcvars_path%" == "" (
  echo The path to vcvars dir was not found.
  exit /b 13
)

if not exist "%vcvars_path%" (
  echo The vcvars path does not exists: "%vcvars_path%".
  exit /b 14
)

set vcvars=%vcvars_path%vcvars%bits%.bat

if not exist "%vcvars%" (
  echo The "%vcvars%" does not exists.
  exit /b 15
)

call "%vcvars%"
