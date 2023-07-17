# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(ncnn_yolox_library VERSION 0.0.1 LANGUAGES C CXX)

get_filename_component(MY_PROJ ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)

# packages

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(ncnn_DIR "${MY_PROJ}/linux/ncnn-20230517-ubuntu-2204-shared/lib/cmake")
  set(OpenCV_DIR "${MY_PROJ}/linux/opencv-mobile-4.6.0-ubuntu-2204/lib/cmake")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Android")
  set(ncnn_DIR "${MY_PROJ}/android/ncnn-20230517-android-vulkan-shared/${ANDROID_ABI}/lib/cmake/ncnn")
  set(OpenCV_DIR "${MY_PROJ}/android/opencv-mobile-4.6.0-android/sdk/native/jni")
else()
  message(FATAL_ERROR "system not support: ${CMAKE_SYSTEM_NAME}")
endif()

if(NOT EXISTS ${ncnn_DIR})
  message(FATAL_ERROR "ncnn_DIR not exists: ${ncnn_DIR}")
endif()
if(NOT EXISTS ${OpenCV_DIR})
  message(FATAL_ERROR "OpenCV_DIR not exists: ${OpenCV_DIR}")
endif()

## ncnn

find_package(ncnn REQUIRED)
message(STATUS "ncnn_FOUND: ${ncnn_FOUND}")

## opencv

find_package(OpenCV 4 REQUIRED)
message(STATUS "OpenCV_VERSION: ${OpenCV_VERSION}")
message(STATUS "OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}")
message(STATUS "OpenCV_LIBS: ${OpenCV_LIBS}")

# targets

include_directories(
  ${MY_PROJ}/src
  ${OpenCV_INCLUDE_DIRS}
)

## ncnn_yolox

add_library(ncnn_yolox SHARED
  "ncnn_yolox.cc"
)
target_link_libraries(ncnn_yolox ncnn ${OpenCV_LIBS})

set_target_properties(ncnn_yolox PROPERTIES
  PUBLIC_HEADER ncnn_yolox.h
  OUTPUT_NAME "ncnn_yolox"
)

target_compile_definitions(ncnn_yolox PUBLIC DART_SHARED_LIB)

## ncnn_yolox_test

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  add_executable(ncnn_yolox_test
    ${MY_PROJ}/linux/ncnn_yolox_test.cc
  )
  target_link_libraries(ncnn_yolox_test ncnn_yolox ${OpenCV_LIBS})
  set_target_properties(ncnn_yolox_test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${MY_PROJ}/linux/build"
  )
endif()
