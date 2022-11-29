cmake_minimum_required(VERSION 3.8)

project("Hybrid")

set(CMAKE_OSX_ARCHITECTURES "x86_64")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

add_subdirectory("Main")