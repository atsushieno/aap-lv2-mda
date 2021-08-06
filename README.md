# aap-lv2-mda: mda-lv2 plugins ported to Android Audio Plugin

This repository is for ports of [mda-lv2](https://gitlab.com/drobilla/mda-lv2) plugins example for [AAP](https://github.com/atsushieno/android-audio-plugin-framework/). It is powered by LV2 using [aap-lv2](https://github.com/atsushieno/aap-lv2/).

## Building

`make` should take care of the builds. See [GitHub Actions script](.github/workflows/actions.yml) for further normative setup.

We submodule mda-lv2, but we use our own CMakeLists.txt (instead of waf build script) so that we can easily debug into mda-lv2 sources using Android Studio.

## Debugging with mda-lv2 internals

It used to be difficult and complicated to step into LV2 toolkit sources (serd/sord/sratom/lilv), but now aap-lv2 builds those toolkits within its `androidaudioplugin-lv2` module (instead of prebuilt binaries), it is just a matter of adding `external/aap-lv2/androidaudioplugin-lv2` as a module.


## Licensing notice

aap-lv2-mda codebase itself is distributed under the MIT license.

LV2 (repository for the headers) is under the ISC license.

`mda-lv2` is distributed under the GPL v3 license.

The entire plugin application bundles `androidaudioplugin-lv2` AAR module from `aap-lv2`, and modules in android-audio-plugin-framework repository (e.g. `androidaudioplugin`) as well, which are all distributed under the MIT license.

They are packaged into the application apk.
