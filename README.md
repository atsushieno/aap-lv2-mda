# aap-lv2-mda: mda-lv2 plugins ported to Android Audio Plugin

This repository is for ports of [mda-lv2](https://gitlab.com/drobilla/mda-lv2) plugins example for [AAP](https://github.com/atsushieno/android-audio-plugin-framework/). It is powered by LV2 using [aap-lv2](https://github.com/atsushieno/aap-lv2/).

It was part of aap-lv2 repository, but now it is split here.

## Building

`make` should take care of the builds. See [GitHub Actions script](.github/workflows/actions.yml) for further normative setup.

At this state, it downloads prebuilt mda-lv2 binaries from [android-native-audio-builders](https://github.com/atsushieno/android-native-audio-builders) release artifacts. It is going to change... we will build mda-lv2 from sources.

## Licensing notice

aap-lv2-mda codebase is distributed under the MIT license.

LV2 (repository for the headers) is under the ISC license.

`mda-lv2` is distributed under the GPL v3 license.

`aap-fluidsynth/src/main/assets/FluidR3Mono_GM.sf3` is a binary copy of the same file from [`fluidr3mono-gm-soundfont` debian package](https://ubuntu.pkgs.org/18.04/ubuntu-universe-amd64/fluidr3mono-gm-soundfont_2.315-4_all.deb.html) and it is licensed under the MIT license.

The entire plugin application bundles `androidaudioplugin-lv2` AAR module from `aap-lv2`, and `androidaudioplugin` AAR module, and is packaged into one application.
