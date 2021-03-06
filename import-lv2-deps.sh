#!/bin/bash

AAP_LV2_DIR=external/aap-lv2/
ABIS_SIMPLE=(x86 x86_64 armeabi-v7a arm64-v8a)

# Remove existing jniLibs for sanity
rm -rf aap-mda-lv2/src/main/jniLibs/

for abi in ${ABIS_SIMPLE[*]}
do
    echo "ABI: $abi"
    # copy native libs of LV2 plugins for each ABI.
    mkdir -p aap-mda-lv2/src/main/jniLibs/$abi
    cp -R dependencies/lv2-deps/dist/$abi/lib/lv2/*/*.so aap-mda-lv2/src/main/jniLibs/$abi/
done

# Copy LV2 metadata files etc.
# The non-native parts should be the same so we just copy files from x86 build.
#
# Also, we only need `mda.lv2` here. Avoid copying those LV2 (SDK) files.
# But not that when you are copying this script, you should probably
# NOT name a specific plugin.
#
mkdir -p aap-mda-lv2/src/main/assets/lv2
cp -R dependencies/lv2-deps/dist/x86/lib/lv2/mda.lv2 aap-mda-lv2/src/main/assets/lv2/
# ... except for *.so files. They are stored under jniLibs.
rm aap-mda-lv2/src/main/assets/lv2/*/*.so

# Generate `aap-metadata.xml` that AAP service look up plugins.
mkdir -p aap-mda-lv2/src/main/assets/lv2
mkdir -p aap-mda-lv2/src/main/res/xml
$AAP_LV2_DIR/tools/aap-import-lv2-metadata/build/aap-import-lv2-metadata \
	aap-mda-lv2/src/main/assets/lv2 \
	aap-mda-lv2/src/main/res/xml

