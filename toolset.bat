@echo off

rem MS Visual C++ projects have the `PlatformToolset` XML property. Here we set
rem the `PLATFORM_TOOLSET` environment variable in format "vXXY", based on the
rem `VCToolsVersion` of format "XX.YY.ZZZZZ". For example, if `VCToolsVersion`
rem is "14.29.30037", then `PLATFORM_TOOLSET` should be "v142".

for /f "tokens=1,2 delims=." %%i in ("%VCToolsVersion%") do (
  set XX=%%i
  set YY=%%j
)

set PLATFORM_TOOLSET=v%XX%%YY:~0,1%
echo PLATFORM_TOOLSET is %PLATFORM_TOOLSET%
