@echo off

rem  Default minimal VS Tools installation.

setlocal
set EXE=vs_buildtools.exe
set URL=https://aka.ms/vs/17/release/%EXE%
set installer=%TEMP%\%EXE%
call download %URL% "%installer%"

rem  https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2022
call "%installer%" --quiet ^
  --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^
  --add Microsoft.VisualStudio.Component.Windows10SDK

del "%installer%"
echo Visual Studio will finish installation silently!
endlocal
