cmake_minimum_required(VERSION 3.15)

if(POLICY CMP0091)
  cmake_policy(SET CMP0091 NEW)
  if(WIN32)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
  endif()
endif()

project(Modelica_Standard_Library_Tables C)

include(Modelica_platform.cmake)
include(Modelica_utilities.cmake)

set(MODELICA_RESOURCES_DIR "${PROJECT_SOURCE_DIR}/../..")
get_filename_component(ABSOLUTE_MODELICA_RESOURCES_DIR "${MODELICA_RESOURCES_DIR}" ABSOLUTE)
set(CMAKE_INSTALL_PREFIX "${ABSOLUTE_MODELICA_RESOURCES_DIR}" CACHE PATH "Library installation prefix path (don't change)" FORCE)

get_modelica_platform_name_with_compiler_version(MODELICA_PLATFORM_NAME)
set(CMAKE_INSTALL_LIBDIR "${CMAKE_INSTALL_PREFIX}/Library/${MODELICA_PLATFORM_NAME}" CACHE PATH "Library installation path (don't change)" FORCE)

include(compiler_options.cmake)
include(options.cmake)
include(test.cmake)
include(src.cmake)
