if(MODELICA_BUILD_TESTING)
  set(MODELICA_TEST_DIR_AUX "${MODELICA_RESOURCES_DIR}/../../.CI/Test")
  get_filename_component(MODELICA_TEST_DIR "${MODELICA_TEST_DIR_AUX}" ABSOLUTE)
  if(EXISTS "${MODELICA_TEST_DIR}")
    enable_testing()
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
    foreach(test_file ${MODELICA_TESTS})
      set(TEST_EXECUTABLE Test${test_file})
      add_executable(${TEST_EXECUTABLE} "${MODELICA_TEST_DIR}/${test_file}.c")
      target_link_libraries(${TEST_EXECUTABLE}
        ModelicaExternalC
        ModelicaStandardTables
        ModelicaIO
        ModelicaMatIO
      )
      if(MODELICA_BUILD_ZLIB)
        target_link_libraries(${TEST_EXECUTABLE} zlib)
      else()
        target_link_libraries(${TEST_EXECUTABLE} z)
      endif()
      if(UNIX)
        target_link_libraries(${TEST_EXECUTABLE} m)
      endif()
      set_target_properties(${TEST_EXECUTABLE} PROPERTIES FOLDER "Test")
      add_test(
        NAME ${TEST_EXECUTABLE}
        COMMAND ${TEST_EXECUTABLE}
        WORKING_DIRECTORY "${MODELICA_TEST_DIR}"
      )
    endforeach()
  else()
    message(WARNING
      " Testsuite not found in \"${MODELICA_TEST_DIR}\"."
      " Set MODELICA_BUILD_TESTING to OFF to silence this warning."
    )
  endif()
endif()
