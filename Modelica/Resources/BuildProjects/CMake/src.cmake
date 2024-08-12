if(NOT HAVE_LOCALE_H)
  add_definitions(-DNO_LOCALE)
endif()
if(NOT HAVE_PTHREAD_H AND NOT WIN32)
  add_definitions(-DNO_MUTEX)
endif()
if(HAVE_STDARG_H)
  add_definitions(-DHAVE_STDARG_H)
endif()
if(HAVE_UNISTD_H)
  add_definitions(-DHAVE_UNISTD_H)
endif()
if(NOT HAVE_DIRENT_H AND NOT WIN32)
  add_definitions(-DNO_FILE_SYSTEM)
endif()
if(NOT HAVE_TIME_H)
  add_definitions(-DNO_TIME)
endif()
if(HAVE_UNISTD_H AND NOT HAVE_GETPID)
  add_definitions(-DNO_PID)
endif()
if(HAVE_MEMCPY)
  add_definitions(-DHAVE_MEMCPY)
endif()
if(HAVE_FSEEKO)
  add_definitions(-DHAVE_FSEEKO)
endif()
if(HAVE_FTELLO)
  add_definitions(-DHAVE_FTELLO)
endif()
if(HAVE_FSEEKO64)
  add_definitions(-DHAVE_FSEEKO64)
endif()
if(HAVE_FTELLO64)
  add_definitions(-DHAVE_FTELLO64)
endif()

if(UNIX)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-attributes -fno-delete-null-pointer-checks")
elseif(MSVC)
  add_definitions(-D_CRT_SECURE_NO_WARNINGS /W3)
endif()

set(MODELICA_SOURCE_DIR "${MODELICA_RESOURCES_DIR}/C-Sources")

if(MODELICA_BUILD_ZLIB)
  set(ZLIB_INCLUDE_DIR "${MODELICA_SOURCE_DIR}/zlib")
  file(TO_CMAKE_PATH ${ZLIB_INCLUDE_DIR} ZLIB_INCLUDE_DIR)
elseif(DEFINED ZLIB_INCLUDE_DIR)
  if(NOT ZLIB_INCLUDE_DIR STREQUAL "")
    file(TO_CMAKE_PATH ${ZLIB_INCLUDE_DIR} ZLIB_INCLUDE_DIR)
  else()
    message(FATAL_ERROR "ZLIB_INCLUDE_DIR is an empty string.")
  endif()
else()
  set(ZLIB_INCLUDE_DIR "" CACHE PATH "Include directory of the zlib.h header file")
  if(NOT ZLIB_INCLUDE_DIR STREQUAL "")
    file(TO_CMAKE_PATH ${ZLIB_INCLUDE_DIR} ZLIB_INCLUDE_DIR)
  else()
    message(FATAL_ERROR "ZLIB_INCLUDE_DIR is an empty string.")
  endif()
endif()

set(EXTC_SOURCES
  "${MODELICA_SOURCE_DIR}/ModelicaFFT.c"
  "${MODELICA_SOURCE_DIR}/ModelicaFFT.h"
  "${MODELICA_SOURCE_DIR}/ModelicaInternal.c"
  "${MODELICA_SOURCE_DIR}/ModelicaInternal.h"
  "${MODELICA_SOURCE_DIR}/ModelicaRandom.c"
  "${MODELICA_SOURCE_DIR}/ModelicaRandom.h"
  "${MODELICA_SOURCE_DIR}/ModelicaStrings.c"
  "${MODELICA_SOURCE_DIR}/ModelicaStrings.h"
  "${MODELICA_SOURCE_DIR}/gconstructor.h"
  "${MODELICA_SOURCE_DIR}/stdint_msvc.h"
  "${MODELICA_SOURCE_DIR}/stdint_wrap.h"
  "${MODELICA_SOURCE_DIR}/uthash.h"
  "${MODELICA_SOURCE_DIR}/win32_dirent.c"
  "${MODELICA_SOURCE_DIR}/win32_dirent.h"
  "${MODELICA_UTILITIES_INCLUDE_DIR}/ModelicaUtilities.h"
)

set(TABLES_SOURCES
  "${MODELICA_SOURCE_DIR}/ModelicaStandardTables.c"
  "${MODELICA_SOURCE_DIR}/ModelicaStandardTables.h"
  "${MODELICA_SOURCE_DIR}/ModelicaStandardTablesUsertab.c"
  "${MODELICA_SOURCE_DIR}/ModelicaMatIO.h"
  "${MODELICA_SOURCE_DIR}/gconstructor.h"
  "${MODELICA_SOURCE_DIR}/stdint_msvc.h"
  "${MODELICA_SOURCE_DIR}/stdint_wrap.h"
  "${MODELICA_SOURCE_DIR}/uthash.h"
  "${MODELICA_UTILITIES_INCLUDE_DIR}/ModelicaUtilities.h"
)

set(MATIO_SOURCES
  "${MODELICA_SOURCE_DIR}/ModelicaMatIO.c"
  "${MODELICA_SOURCE_DIR}/ModelicaMatIO.h"
  "${MODELICA_SOURCE_DIR}/read_data_impl.h"
  "${MODELICA_SOURCE_DIR}/safe-math.h"
  "${MODELICA_SOURCE_DIR}/snprintf.c"
  "${MODELICA_SOURCE_DIR}/stdint_msvc.h"
  "${ZLIB_INCLUDE_DIR}/zlib.h"
  "${MODELICA_UTILITIES_INCLUDE_DIR}/ModelicaUtilities.h"
)

set(IO_SOURCES
  "${MODELICA_SOURCE_DIR}/ModelicaIO.c"
  "${MODELICA_SOURCE_DIR}/ModelicaIO.h"
  "${MODELICA_SOURCE_DIR}/ModelicaMatIO.h"
  "${MODELICA_UTILITIES_INCLUDE_DIR}/ModelicaUtilities.h"
)

if(MODELICA_BUILD_ZLIB)
  file(GLOB ZLIB_SOURCES
    "${MODELICA_SOURCE_DIR}/zlib/*.c"
    "${MODELICA_SOURCE_DIR}/zlib/*.h"
  )
endif()

add_library(ModelicaExternalC STATIC ${EXTC_SOURCES})
add_library(ModelicaStandardTables STATIC ${TABLES_SOURCES})
add_library(ModelicaMatIO STATIC ${MATIO_SOURCES})
add_library(ModelicaIO STATIC ${IO_SOURCES})

if(MODELICA_BUILD_ZLIB)
  add_library(zlib STATIC ${ZLIB_SOURCES})
endif()

if(MODELICA_DEBUG_TIME_EVENTS)
  target_compile_definitions(ModelicaStandardTables PRIVATE -DDEBUG_TIME_EVENTS=1)
endif()
if(MODELICA_SHARE_TABLE_DATA)
  target_compile_definitions(ModelicaStandardTables PRIVATE -DTABLE_SHARE=1)
endif()
if(NOT MODELICA_COPY_TABLE_DATA)
  target_compile_definitions(ModelicaStandardTables PRIVATE -DNO_TABLE_COPY=1)
endif()
if(MODELICA_DUMMY_FUNCTION_USERTAB OR BUILD_TESTING)
  target_compile_definitions(ModelicaStandardTables PRIVATE -DDUMMY_FUNCTION_USERTAB=1)
endif()
if(MODELICA_BUILD_ZLIB AND (HAVE_WINAPIFAMILY_H OR HAVE_IO_H) AND NOT CYGWIN)
  target_compile_definitions(zlib PRIVATE -DWINAPI_FAMILY=100)
endif()
target_compile_definitions(ModelicaMatIO PRIVATE -DHAVE_ZLIB=1)
target_include_directories(ModelicaMatIO PRIVATE ${ZLIB_INCLUDE_DIR})
if(MSVC)
  target_compile_options(ModelicaMatIO PRIVATE /wd4267)
endif()

install(
  TARGETS ModelicaStandardTables ModelicaMatIO ModelicaIO
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

if(MODELICA_BUILD_ZLIB)
  install(
    TARGETS zlib
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
endif()

if(MODELICA_INSTALL_EXTC)
  install(
    TARGETS ModelicaExternalC
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
endif()
