include(CTest)

if(BUILD_TESTING)
  set(MODELICA_TEST_SOURCE_DIR "${PROJECT_SOURCE_DIR}/../../../../.CI/Test")
  get_filename_component(ABSOLUTE_MODELICA_TEST_SOURCE_DIR "${MODELICA_TEST_SOURCE_DIR}" ABSOLUTE)
  if(EXISTS "${ABSOLUTE_MODELICA_TEST_SOURCE_DIR}")
    set(MODELICA_TESTS
      FileSystem
      ModelicaStrings
      Streams
      Tables
      TablesFromCsvFile
      TablesFromMatFile
      TablesFromTxtFile
      TablesNoUsertab
    )
    foreach(TEST ${MODELICA_TESTS})
      add_executable(Test${TEST} "${ABSOLUTE_MODELICA_TEST_SOURCE_DIR}/${TEST}.c")
      target_link_libraries(Test${TEST} ModelicaExternalC ModelicaStandardTables ModelicaIO ModelicaMatIO)
      if(MODELICA_BUILD_ZLIB)
        target_link_libraries(Test${TEST} zlib)
      else()
        target_link_libraries(Test${TEST} z)
      endif()
      if(UNIX)
        target_link_libraries(Test${TEST} m)
      endif()
      add_test(NAME Test${TEST} COMMAND Test${TEST} WORKING_DIRECTORY "${ABSOLUTE_MODELICA_TEST_SOURCE_DIR}")
    endforeach()
  else()
    message(WARNING
      " Testsuite not found in \"${ABSOLUTE_MODELICA_TEST_SOURCE_DIR}\"."
      " Set BUILD_TESTING to OFF to silence this warning."
    )
  endif()
endif()
