# aap-lv2-mda: mda-lv2 plugins ported to Android Audio Plugin

This repository is for ports of [mda-lv2](https://gitlab.com/drobilla/mda-lv2) plugins example for [AAP](https://github.com/atsushieno/android-audio-plugin-framework/). It is powered by LV2 using [aap-lv2](https://github.com/atsushieno/aap-lv2/).

It was part of aap-lv2 repository, but now it is split here.

## Building

`make` should take care of the builds. See [GitHub Actions script](.github/workflows/actions.yml) for further normative setup.

At this state, it downloads prebuilt mda-lv2 binaries from [android-native-audio-builders](https://github.com/atsushieno/android-native-audio-builders) release artifacts. It is going to change... we will build mda-lv2 from sources.


## Debugging with mda-lv2 internals

Similar to the section on lilv internals in [aap-lv2](https://github.com/atsushieno/aap-lv2) README, it is also possible to build and debug mda-lv2 with sources. However, the required changes are different - especially in that it needs metadata changes.

- create symbolic from `android-native-audio-builders/mda-lv2` to (some path like) `aap-mda-lv2/src/mda_direct`
- add the sources to `CMakeLists.txt`, but you can build only one plugin because mda-lv2 iterates source builds in its waf land. `lvz/*.cpp` are required with any plugin.
- You will have to define some variables to compile sources. (see below)
- add `lvz` and `src` directories to `target_include_directories`.
- in `assets/lv2/mda-lv2/manifest.ttl`, find your target plugin to change and replace its `.so` file with `libaap-mda-lv2.so` (the one you are going to build). lilv will load the specified library.

The additional definitions you need:

```
        -DPLUGIN_CLASS=mdaEPiano
        -DURI_PREFIX="http://drobilla.net/plugins/mda/"
        -DPLUGIN_URI_SUFFIX="EPiano"
        -DPLUGIN_HEADER="mdaEPiano.h"
```

[An example patch](https://gist.github.com/atsushieno/a233bc7a527c02ef562b4151647ff698) which once worked is provided for reference (the directory structure is not strictly following the list above, also it was created when this plugin was part of aap-lv2 repo, but you would get the ideas).


## Licensing notice

aap-lv2-mda codebase is distributed under the MIT license.

LV2 (repository for the headers) is under the ISC license.

`mda-lv2` is distributed under the GPL v3 license.

The entire plugin application bundles `androidaudioplugin-lv2` AAR module from `aap-lv2`, and `androidaudioplugin` AAR module, and is packaged into one application.
