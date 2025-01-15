cmake_minimum_required(VERSION 3.15)

if(POLICY CMP0091)
  cmake_policy(SET CMP0091 NEW)
  if(WIN32)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
  endif()
endif()

project(Modelica_Standard_Library_Tables C)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

include(BuildProjects/CMake/Modelica_platform.cmake)
include(BuildProjects/CMake/Modelica_utilities.cmake)

set(MODELICA_RESOURCES_DIR "${PROJECT_SOURCE_DIR}")
set(
  CMAKE_INSTALL_PREFIX "${MODELICA_RESOURCES_DIR}"
  CACHE PATH
  "Library installation prefix path (don't change)" FORCE
)

get_modelica_platform_name_with_compiler_version(MODELICA_PLATFORM_NAME)
set(
  CMAKE_INSTALL_LIBDIR "${CMAKE_INSTALL_PREFIX}/Library/${MODELICA_PLATFORM_NAME}"
  CACHE PATH
  "Library installation path (don't change)" FORCE
)

include(BuildProjects/CMake/compiler_options.cmake)
include(BuildProjects/CMake/options.cmake)
include(BuildProjects/CMake/test.cmake)
include(BuildProjects/CMake/src.cmake)
