
PWD=$(shell pwd)
AAP_LV2_DIR=$(PWD)/external/aap-lv2

all: build-all

build-all: \
	build-aap-lv2 \
	get-lv2-deps \
	import-lv2-deps \
	build-java

build-aap-lv2:
	cd $(AAP_LV2_DIR) && make

## downloads

get-lv2-deps: dependencies/lv2-deps/dist/stamp

dependencies/lv2-deps/dist/stamp: android-lv2-binaries.zip
	mkdir -p dependencies/lv2-deps
	unzip android-lv2-binaries -d dependencies/lv2-deps/
	./rewrite-pkg-config-paths.sh lv2-deps
	if [ ! -d aap-mda-lv2/src/main/cpp/symlinked-dist ] ; then \
		ln -s $(PWD)/dependencies/lv2-deps/dist aap-mda-lv2/src/main/cpp/symlinked-dist ; \
	fi
	touch dependencies/lv2-deps/dist/stamp

android-lv2-binaries.zip:
	wget https://github.com/atsushieno/android-native-audio-builders/releases/download/r8.3/android-lv2-binaries.zip

# Run importers

import-lv2-deps:
	./import-lv2-deps.sh

## Build utility

build-java:
	ANDROID_SDK_ROOT=$(ANDROID_SDK_ROOT) ./gradlew build
 
## update metadata

update-metadata:
	cd external/aap-lv2 && make build-lv2-importer
	external/aap-lv2/tools/aap-import-lv2-metadata/build/aap-import-lv2-metadata aap-mda-lv2/src/main/assets/lv2 aap-mda-lv2/src/main/res/xml

