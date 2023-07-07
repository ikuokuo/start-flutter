# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

# Project-level configuration.
set(PROJECT_NAME "ncnn_yolox")
project(${PROJECT_NAME} LANGUAGES C CXX)

set(MY_CURR ${PROJECT_SOURCE_DIR})

message(STATUS "CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")

# packages

set(ncnn_DIR "${MY_CURR}/ncnn-20230517-ubuntu-2204-shared")
set(OpenCV_DIR "${MY_CURR}/opencv-mobile-4.6.0-ubuntu-2204")

if(NOT EXISTS ${ncnn_DIR})
  message(FATAL_ERROR "ncnn_DIR not exists: ${ncnn_DIR}")
endif()
if(NOT EXISTS ${OpenCV_DIR})
  message(FATAL_ERROR "OpenCV_DIR not exists: ${OpenCV_DIR}")
endif()

LIST(APPEND CMAKE_PREFIX_PATH ${ncnn_DIR}/lib/cmake)
LIST(APPEND CMAKE_PREFIX_PATH ${OpenCV_DIR}/lib/cmake)

## ncnn

set(OpenMP_C_FLAGS "-fopenmp")
set(OpenMP_CXX_FLAGS "-fopenmp")

find_package(ncnn REQUIRED)
message(STATUS "ncnn_FOUND: ${ncnn_FOUND}")

## opencv

find_package(OpenCV 4 REQUIRED)
message(STATUS "OpenCV_VERSION: ${OpenCV_VERSION}")
message(STATUS "OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}")
message(STATUS "OpenCV_LIBS: ${OpenCV_LIBS}")

include_directories(
  ${OpenCV_INCLUDE_DIRS}
)

# Invoke the build for native code shared with the other target platforms.
# This can be changed to accommodate different builds.
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../src" "${CMAKE_CURRENT_BINARY_DIR}/shared")

file(GLOB ncnn_bundled_libraries "${ncnn_DIR}/lib/libncnn.so*")
message(STATUS "ncnn_bundled_libraries: ${ncnn_bundled_libraries}")

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
set(ncnn_yolox_bundled_libraries
  # Defined in ../src/CMakeLists.txt.
  # This can be changed to accommodate different builds.
  $<TARGET_FILE:ncnn_yolox>
  ${ncnn_bundled_libraries}
  PARENT_SCOPE
)
message(STATUS "ncnn_yolox_bundled_libraries: ${ncnn_yolox_bundled_libraries}")

## ncnn_yolox_test

include_directories(
  ${MY_CURR}/../src
)

add_executable(ncnn_yolox_test ncnn_yolox_test.cc)
target_link_libraries(ncnn_yolox_test ncnn_yolox ${OpenCV_LIBS})
