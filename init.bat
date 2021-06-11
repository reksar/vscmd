@echo off

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

rem Set default arch.
if not "%x%" == "86" (
  if not "%x%" == "64" (
    set x=64
  )
)
