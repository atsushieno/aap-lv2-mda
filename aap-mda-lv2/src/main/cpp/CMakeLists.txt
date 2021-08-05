cmake_minimum_required(VERSION 3.6.0)

project("aap-mda-lv2")

set(MDA_LV2_DIR ../../../../external/mda-lv2)

FILE(GLOB PLUGIN_CPP_FILES ${MDA_LV2_DIR}/src/*.cpp)
list(FILTER PLUGIN_CPP_FILES EXCLUDE REGEX ".*mdaLooplex.cpp")
FILE(GLOB LVZ_SOURCES ${MDA_LV2_DIR}/lvz/*.cpp)

foreach(PLUGIN_CPP IN ITEMS ${PLUGIN_CPP_FILES})

    message(${PLUGIN_CPP})

    get_filename_component(PLUGIN_CPP_WE ${PLUGIN_CPP} NAME_WE)
    get_filename_component(MDA_LV2_FULL_PATH ${PLUGIN_CPP} ABSOLUTE)

    string(LENGTH ${PLUGIN_CPP_WE} CPPWELEN)

    string(SUBSTRING ${PLUGIN_CPP_WE} 3 -1 PLUGIN_NAME)

    message("Generating build rules for ${PLUGIN_NAME} ...")

    add_library( ${PLUGIN_NAME}
        SHARED
        ${PLUGIN_CPP}
        ${LVZ_SOURCES}
    )

    set_target_properties(${PLUGIN_NAME}
        PROPERTIES PREFIX ""
    )

    target_compile_definitions( ${PLUGIN_NAME}
        PUBLIC
        PLUGIN_CLASS=mda${PLUGIN_NAME}
        URI_PREFIX="http://drobilla.net/plugins/mda/"
        PLUGIN_URI_SUFFIX="${PLUGIN_NAME}"
        PLUGIN_HEADER="../src/mda${PLUGIN_NAME}.h"
        PTHREAD_CANCEL_DISABLE=0 # dummy
    )

    target_include_directories( ${PLUGIN_NAME}
        PRIVATE
        ../../../../external/lv2/
        ${MDA_LV2_DIR}/lvz/
        "${Project_SOURCE_DIR}/../../../../../../native/plugin-api/include"
        "${Project_SOURCE_DIR}/../../../../../../native/androidaudioplugin/core/include"
        "${Project_SOURCE_DIR}/../../../../../../native/androidaudioplugin/android/src/gen/include"
    )

    target_compile_options( ${PLUGIN_NAME}
        PRIVATE
        -std=c++17
        -Wall
        -Wextra-semi
        -Wshadow
        -Wshadow-field
        )

    target_link_libraries( ${PLUGIN_NAME} android log)

endforeach()

