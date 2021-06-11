@echo off

rem Initializes the VS Tools CLI, e.g. for use the `cl` compiler or `msbuild` 
rem in third-party batch scripts. Like VS Tools Command Prompt from Start menu, 
rem but for scripting rather than manual use.

rem We cannot use the same VS Tools Command Prompt for this purpose, because 
rem it runs `cmd.exe` with the `/k` key, which prevents exit after the 
rem `vcvvars*.bat` is executed.

rem Instead we need to call the `vcvvars*.bat` script here.

rem VS Build Tools may be installed to a non-default path, so we use the link 
rem at the Start menu to determine the path to the `vcvars*.bat`.

set vcvars_name=x64 Native Tools Command Prompt for VS 2019

set vcvars_lnk=%ProgramData%\Microsoft\Windows\Start Menu\Programs
set vcvars_lnk=%vcvars_lnk%\Visual Studio 2019\Visual Studio Tools\VC
set vcvars_lnk=%vcvars_lnk%\%vcvars_name%.lnk

if not exist "%vcvars_lnk%" (
  echo The link "%vcvars_name%" is not exists in "%vcvars_lnk%".
  exit /b 1
)

rem The native Windows methods for getting a link's target are crappy: wmic is 
rem deprecated, the lame powershell's object leads to the target - %comspec% 
rem (cmd.exe), but discards the params tail that contains the required path.

rem But we can TYPE "%vcvars_lnk%" and find out the needed path in the output.

rem Here is another crap: the target path in TYPE's output looks pretty, alas.
rem But actually it is some like:
rem "C : \ ... \ A u x i l i a r y \ B u i l d \ v c v a r s 6 4 . b a t",
rem where spaces are null bytes.

rem We need an analogue of `tr -d "\000" | grep -o "<pattern>"` for Windows.

rem Let's find the path to this file:
set target_file=vcvars.*\.bat

rem The sought path pattern.
rem A link text may contain several paths. We need to prevent greedy matching.
rem Using the "[^^^^:]" pattern means "not a colon" and helps to cut off any 
rem previous ".:" matches until last matched.
set vcvars_path_pattern=.:\\[^^^^:]*\\%target_file%

rem Read the link text and remove null bytes to transform the
rem "C : \ ... \ A u x i l i a r y \ B u i l d \ v c v a r s 6 4 . b a t",
rem to the "C:\...\Auxiliary\Build\vcvars64.bat".
set read_link=$(Get-Content -Path '%vcvars_lnk%') -replace '\x00', ''

rem Select only the line with the vcvars path.
set find_path=Select-String -Pattern '%vcvars_path_pattern%'

rem Cut only the vcvars path from the line.
set only_match=ForEach-Object{$_.Matches.Groups[0].Value}

rem Call the `vcvvars` batch script.
for /f "usebackq delims=" %%i in (`
  powershell -command "%read_link% | %find_path% | %only_match%"
`) do (
  call "%%i" || exit
)
