@echo off

set batch_path=%~d0%~p0

:parse_args
if not "%1" == "" (

  rem Architecture: -x 64 or -x 86
  if "%1" == "-x" (
    set x=%2
    shift
  )

  rem If needed to set `PLATFORM_TOOLSET`
  if "%1" == "-toolset" (
    set toolset=true
  )

  shift
  goto :parse_args
)

rem ---------------------------------------------------------------------------

if not "%x%" == "86" (
  if not "%x%" == "64" (
    set x=64
  )
)

if "%x%" == "86" (
  set bits=32
) else (
  set bits=%x%
)

rem ---------------------------------------------------------------------------

call "%batch_path%vcvars.bat" "%bits%" || goto :EOF

if "%toolset%" == "true" (
  call "%batch_path%toolset.bat" || goto :EOF
)
