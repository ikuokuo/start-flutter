cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(yolox VERSION 1.0.0 LANGUAGES C CXX)

set(MY_CURR ${PROJECT_SOURCE_DIR})
get_filename_component(MY_ROOT "${MY_CURR}/../.." ABSOLUTE)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

message(STATUS "MY_ROOT: ${MY_ROOT}")
message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
#set(CMAKE_VERBOSE_MAKEFILE ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED on)

# packages

set(ncnn_DIR "${MY_CURR}/ncnn-20230517-ubuntu-2204-shared/lib/cmake")
set(OpenCV_DIR "${MY_CURR}/opencv-mobile-4.6.0-ubuntu-2204/lib/cmake")

if(NOT EXISTS ${ncnn_DIR})
  message(FATAL_ERROR "ncnn_DIR not exists: ${ncnn_DIR}")
endif()
if(NOT EXISTS ${OpenCV_DIR})
  message(FATAL_ERROR "OpenCV_DIR not exists: ${OpenCV_DIR}")
endif()

LIST(APPEND CMAKE_PREFIX_PATH ${ncnn_DIR})
LIST(APPEND CMAKE_PREFIX_PATH ${OpenCV_DIR})

## ncnn

find_package(ncnn REQUIRED)
message(STATUS "ncnn_FOUND: ${ncnn_FOUND}")

## opencv

find_package(OpenCV 4 REQUIRED)
message(STATUS "OpenCV_VERSION: ${OpenCV_VERSION}")
message(STATUS "OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}")
message(STATUS "OpenCV_LIBS: ${OpenCV_LIBS}")

# targets

## yolox

set(YOLOX_DIR ${MY_ROOT}/lib/yolox)

include_directories(
  ${YOLOX_DIR}
  ${OpenCV_INCLUDE_DIRS}
)

add_library(yolox SHARED
  ${YOLOX_DIR}/yolox.cc
)
target_link_libraries(yolox ncnn ${OpenCV_LIBS})
set_target_properties(yolox PROPERTIES
  PUBLIC_HEADER ${YOLOX_DIR}/yolox.h
  VERSION ${PROJECT_VERSION}
  SOVERSION 1
  OUTPUT_NAME "yolox"
  XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)

## yolox_test

add_executable(yolox_test yolox_test.cc)
target_link_libraries(yolox_test yolox ${OpenCV_LIBS})

# install

include(GNUInstallDirs)
install(TARGETS yolox yolox_test
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
