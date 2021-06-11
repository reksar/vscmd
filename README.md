# vscmd

Like the **VS Tools Command Prompt** from the Windows Start menu, but **for 
batch scripting** rather than manual use.

## `vars.bat`

It allows **VS Tools** like `cl` compiler or `msbuild` to be used in batch.

Default link is .

### Example

By default uses the "*x64 Native Tools Command Prompt for VS 2019*" link name.

```batch
call "vars.bat"
```

```batch
[vcvarsall.bat] Environment initialized for: 'x64'
```

Passing this *VCVARS* link name should change the arch.

```batch
call "vars.bat" "x86 Native Tools Command Prompt for VS 2019"
```

```batch
[vcvarsall.bat] Environment initialized for: 'x86'
```

## `toolset.bat`

Calls the `vars.bat`, then sets the `PLATFORM_TOOLSET` env var.

Allows to pass a *VCVARS* link name for `vars.bat` through the `toolset.bat`.

### Example

```batch
call toolset.bat "x86 Native Tools Command Prompt for VS 2019"
```

```batch
[vcvarsall.bat] Environment initialized for: 'x86'
PLATFORM_TOOLSET is v142
```

MS Visual C++ projects have this property:

```xml
<PlatformToolset>v142</PlatformToolset>
```

Using the `PLATFORM_TOOLSET` allows to make a project more flexible:

```xml
<PlatformToolset Condition="'$(PLATFORM_TOOLSET)' == ''">
  v142
</PlatformToolset>

<PlatformToolset Condition="'$(PLATFORM_TOOLSET)' != ''">
  $(PLATFORM_TOOLSET)
</PlatformToolset>
```
