add_executable(${PROJECT_NAME} 
    main.cpp
)

set_target_properties(${PROJECT_NAME} PROPERTIES ENABLE_EXPORTS ON)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        lib
)

install(TARGETS ${PROJECT_NAME} DESTINATION bin)