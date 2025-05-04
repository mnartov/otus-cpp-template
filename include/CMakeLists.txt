add_library(lib STATIC
    lib.cpp
)

target_include_directories(lib PUBLIC
    ${CMAKE_SOURCE_DIR}/include
)