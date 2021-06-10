# vscmd

Like the **VS Tools Command Prompt** from the Windows Start menu, but **for 
batch scripting** rather than manual use.

It allows of **VS Tools** like `cl` compiler or `msbuild` to be used in batch.

## Example

Will be used the "*x64 Native Tools Command Prompt for VS 2019*" by default.

Running of

```batch
call "vars.bat"
echo %VSCMD_ARG_HOST_ARCH%
```

gives `x64`.

We can pass the link name.

Running of

```batch
call "vars.bat" "x86 Native Tools Command Prompt for VS 2019"
echo %VSCMD_ARG_HOST_ARCH%
```

gives `x86`.

