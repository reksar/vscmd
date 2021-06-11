@echo off

rem Sets the env var `PLATFORM_TOOLSET` in format "vXXY" based on the 
rem `VCToolsVersion` of format "XX.YY.ZZZZZ". For example, if the 
rem `VCToolsVersion` is "14.29.30037", then `PLATFORM_TOOLSET` will be "v142".

rem MS Visual C++ projects have the `PlatformToolset` XML property, which is 
rem usually hardcoded in a project's `*.props`. But, if the project is not 
rem sensitive for the Toolset version, it is possible to set the 
rem `PlatformToolset` from the `PLATFORM_TOOLSET` env var and make a project 
rem more flexible.

set batch_path=%~d0%~p0
set vcvars_name=%1

call "%batch_path%vars.bat" %vcvars_name% || exit

for /f "tokens=1,2 delims=." %%i in ("%VCToolsVersion%") do (
  set XX=%%i
  set YY=%%j
)

set PLATFORM_TOOLSET=v%XX%%YY:~0,1%
echo PLATFORM_TOOLSET is %PLATFORM_TOOLSET%
