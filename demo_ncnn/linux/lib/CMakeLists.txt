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

# targets

## yolox

set(YOLOX_DIR ${MY_ROOT}/lib/yolox)

include_directories(
  ${YOLOX_DIR}
)

add_library(yolox SHARED
  ${YOLOX_DIR}/yolox.cc
)
set_target_properties(yolox PROPERTIES
  PUBLIC_HEADER ${YOLOX_DIR}/yolox.h
  VERSION ${PROJECT_VERSION}
  SOVERSION 1
  OUTPUT_NAME "yolox"
  XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)

## yolox_test

add_executable(yolox_test yolox_test.cc)
target_link_libraries(yolox_test yolox)

# install

include(GNUInstallDirs)
install(TARGETS yolox yolox_test
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
