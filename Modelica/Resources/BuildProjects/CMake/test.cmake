include(CTest)

if(BUILD_TESTING)
  set(MODELICA_TEST_DIR_AUX "${MODELICA_RESOURCES_DIR}/../../.CI/Test")
  get_filename_component(MODELICA_TEST_DIR "${MODELICA_TEST_DIR_AUX}" ABSOLUTE)
  if(EXISTS "${MODELICA_TEST_DIR}")
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
      add_executable(Test${TEST} "${MODELICA_TEST_DIR}/${TEST}.c")
      target_link_libraries(Test${TEST}
        ModelicaExternalC
        ModelicaStandardTables
        ModelicaIO
        ModelicaMatIO
      )
      if(MODELICA_BUILD_ZLIB)
        target_link_libraries(Test${TEST} zlib)
      else()
        target_link_libraries(Test${TEST} z)
      endif()
      if(UNIX)
        target_link_libraries(Test${TEST} m)
      endif()
      add_test(
        NAME Test${TEST}
        COMMAND Test${TEST}
        WORKING_DIRECTORY "${MODELICA_TEST_DIR}"
      )
    endforeach()
  else()
    message(WARNING
      " Testsuite not found in \"${MODELICA_TEST_DIR}\"."
      " Set BUILD_TESTING to OFF to silence this warning."
    )
  endif()
endif()
