# vscmd

Requires [Build Tools for Visual Studio](https://visualstudio.microsoft.com/downloads).

Makes **VS Tools Command Prompt** features available inside **batch scripts**:

```batch
init {-x 64 | -x 86} {-toolset}
```

Examples:

```batch
call "vscmd\init" -x 64
call "vscmd\init" -x 64 -toolset
```

Calling `init` without args is the same as `init -x 64` without `-toolset`.

## Platform Toolset

Using the `-toolset` arg `PLATFORM_TOOLSET` env var.

MS Visual C++ projects have this XML property:

```xml
<PlatformToolset>v142</PlatformToolset>
```

With `PLATFORM_TOOLSET` you can do something like:

```xml
<PlatformToolset Condition="'$(PLATFORM_TOOLSET)' == ''">
  v142
</PlatformToolset>

<PlatformToolset Condition="'$(PLATFORM_TOOLSET)' != ''">
  $(PLATFORM_TOOLSET)
</PlatformToolset>
```
