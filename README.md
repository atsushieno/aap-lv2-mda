# aap-lv2-mda: mda-lv2 plugins ported to Audio Plugins For Android

This repository is for ports of [mda-lv2](https://gitlab.com/drobilla/mda-lv2) plugins example for [AAP](https://github.com/atsushieno/aap-core/). It is powered by LV2 using [aap-lv2](https://github.com/atsushieno/aap-lv2/).

## Building

See [GitHub Actions script](.github/workflows/actions.yml) for the normative setup.

For local desktop development, build the local aap-lv2 submodule into Maven Local first, then build this app:

```
$ cd external/aap-lv2/external/aap-core
$ ./gradlew publishToMavenLocal
$ cd ../..
$ ./gradlew :androidaudioplugin-lv2:build :androidaudioplugin-lv2:publishToMavenLocal
$ cd ../..
$ ./gradlew build bundle
```

We submodule mda-lv2, but we use our own CMakeLists.txt (instead of waf build script) so that we can easily debug into mda-lv2 sources using Android Studio.

To avoid further dependencies like cairo, we skip some samples in mda-lv2 port (they are actually skipped at android-native-audio-builders repo).

## Updating Metadata

`aap_metadata.xml` is generated manually when LV2 assets change:

```
$ cd external/aap-lv2
$ cmake -E rm -rf tools/aap-import-lv2-metadata/build
$ cmake -S tools/aap-import-lv2-metadata -B tools/aap-import-lv2-metadata/build -G Ninja -DCMAKE_BUILD_TYPE=Debug
$ cmake --build tools/aap-import-lv2-metadata/build
$ cd ../..
$ external/aap-lv2/tools/aap-import-lv2-metadata/build/aap-import-lv2-metadata app/src/main/assets/lv2 app/src/main/res/xml
```

## Debugging with mda-lv2 internals

It used to be difficult and complicated to step into LV2 toolkit sources (serd/sord/sratom/lilv), but now aap-lv2 builds those toolkits within its `androidaudioplugin-lv2` module (instead of prebuilt binaries), it is just a matter of adding `external/aap-lv2/androidaudioplugin-lv2` as a module.

Here is an example patch: https://gist.github.com/atsushieno/799ea5129c09a616a0b6712fbb8ea5b1

## Licensing notice

aap-lv2-mda codebase itself is distributed under the MIT license.

LV2 (repository for the headers) is under the ISC license.

`mda-lv2` is distributed under the GPL v3 license.

The entire plugin application bundles `androidaudioplugin-lv2` AAR module from `aap-lv2`, and modules in aap-core repository (e.g. `androidaudioplugin`) as well, which are all distributed under the MIT license.

They are packaged into the application apk.
