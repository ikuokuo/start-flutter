# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(ncnn_yolox_library VERSION 0.0.1 LANGUAGES C CXX)

add_library(ncnn_yolox SHARED
  "ncnn_yolox.cc"
)
target_link_libraries(ncnn_yolox ncnn ${OpenCV_LIBS})

set_target_properties(ncnn_yolox PROPERTIES
  PUBLIC_HEADER ncnn_yolox.h
  OUTPUT_NAME "ncnn_yolox"
)

target_compile_definitions(ncnn_yolox PUBLIC DART_SHARED_LIB)
