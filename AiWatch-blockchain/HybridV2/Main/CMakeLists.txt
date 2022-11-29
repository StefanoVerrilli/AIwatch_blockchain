cmake_minimum_required(VERSION 3.8)

set (TARGET_NAME Main)

set(PYBIND11_PYTHON_VERSION 3.9 CACHE STRING "")

#find_package(PythonInterp 3.9 REQUIRED)

set(CMAKE_OSX_ARCHITECTURES "x86_64")

find_package(pybind11 CONFIG REQUIRED)

add_executable(Main "Main.cpp" "Main.h")

target_link_libraries(Main PRIVATE pybind11::embed pybind11::module pybind11::pybind11)