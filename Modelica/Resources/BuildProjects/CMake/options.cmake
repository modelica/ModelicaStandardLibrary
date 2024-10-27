# Option to trace time events
option(MODELICA_DEBUG_TIME_EVENTS "Trace time events of CombiTimeTable" OFF)

# Option to share table arrays
option(
  MODELICA_SHARE_TABLE_DATA
  "Store shared table arrays (read from file) in a global hash table" ON
)

# Option to deep-copy table arrays
option(MODELICA_COPY_TABLE_DATA "Deep-copy table arrays (passed as array)" ON)

# Option to add a dummy function "usertab"
option(MODELICA_DUMMY_FUNCTION_USERTAB "Add a dummy usertab function" OFF)

# Option to build zlib from sources
option(
  MODELICA_BUILD_ZLIB
  "Build zlib from sources in this project, otherwise provide ZLIB_INCLUDE_DIR" ON
)

# Option whether to install ModelicaExternalC
option(MODELICA_INSTALL_EXTC "Install ModelicaExternalC library" OFF)

# Option to enable testsuite
option(MODELICA_BUILD_TESTING "Build testing" ON)

set(BUILD_TESTING OFF)
if(MODELICA_BUILD_TESTING)
  set(BUILD_TESTING ON)
endif()
