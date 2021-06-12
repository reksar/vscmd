@echo off

rem Sets the `vcvars_path` if the path to this target file is found ...
set target_file=vcvars.*\.bat
rem ... in this link.
set lnk=%~1

if not exist "%lnk%" (
  echo No link to read: "%lnk%".
  exit /b 21
)

rem The native Windows methods for getting a link's target are crappy: `wmic` 
rem is deprecated, the lame powershell's object leads to the target - %comspec% 
rem (cmd.exe), but discards the params tail that contains the required path.

rem However, we can `TYPE "%lnk%"` and find out the needed path in the output.

rem Here is another crap: the target path in TYPE's output looks pretty, alas.
rem But actually it is some like:
rem "C : \ ... \ A u x i l i a r y \ B u i l d \ v c v a r s 6 4 . b a t",
rem where spaces are null bytes.

rem Below is the implementation of the Windows-compatible analogue of 
rem `tr -d "\000" | grep -o "<pattern>"`.

rem A link text may contain several paths. We need to prevent greedy matching.
rem Using the "[^^^^:]" pattern means "not a colon" and helps to cut off any 
rem previous ".:" matches until last matched.
set path_pattern=.:\\[^^^^:]*\\%target_file%

rem Read the link text and remove null bytes to transform the
rem "C : \ ... \ A u x i l i a r y \ B u i l d \ v c v a r s 6 4 . b a t",
rem to the "C:\...\Auxiliary\Build\vcvars64.bat".
set read_link=$(Get-Content -Path '%lnk%') -replace '\x00', ''

rem Select only the line with the vcvars path.
set find_path=Select-String -Pattern '%path_pattern%'

rem Cut only the vcvars path from the line.
set only_match=ForEach-Object{$_.Matches.Groups[0].Value}

for /f "usebackq delims=" %%i in (`
  powershell -command "%read_link% | %find_path% | %only_match%"
`) do (
  if not "%%i" == "" (
    set vcvars_path=%%~di%%~pi
  )
)
