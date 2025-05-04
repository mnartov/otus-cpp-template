add_executable(unit_tests
    testMain.cpp
)

target_link_libraries(unit_tests
    PRIVATE
        gtest_main
        lib
)

add_test(NAME unit_tests COMMAND unit_tests)




