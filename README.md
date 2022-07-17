# vscmd

Like the **VS Tools Command Prompt** in the Windows Start menu, but **for 
batch scripting** rather than manual use.

## Install

`install-vs` - default minimal VS Tools installation.

## Platform Toolset

In addition, it allows to set the `PLATFORM_TOOLSET` env var.

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

## Using

`init.bat [-x 64 | -x 86] [-toolset]`.

Defaults are: `-x 64` and no `-toolset`.

```batch
call "vscmd\init.bat"
```

```batch
...
[vcvarsall.bat] Environment initialized for: 'x64'
```

With args:

```batch
call "vscmd\init.bat" -x 86 -toolset
```

```batch
...
[vcvarsall.bat] Environment initialized for: 'x86'
PLATFORM_TOOLSET is v142
```
