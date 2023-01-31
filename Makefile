
PWD=$(shell pwd)
AAP_LV2_DIR=$(PWD)/external/aap-lv2

all: build-all

build-all: \
	build-aap-lv2 \
	build-java

build-aap-lv2:
	cd $(AAP_LV2_DIR) && make

## Build utility

build-java:
	ANDROID_SDK_ROOT=$(ANDROID_SDK_ROOT) ./gradlew build bundle
 
## update metadata

update-metadata:
	cd external/aap-lv2 && make build-lv2-importer
	external/aap-lv2/tools/aap-import-lv2-metadata/build/aap-import-lv2-metadata app/src/main/assets/lv2 app/src/main/res/xml

