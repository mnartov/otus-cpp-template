cmake_minimum_required(VERSION 3.20)

set(PATCH_VERSION "1" CACHE INTERNAL "Patch version")
set(PROJECT_VERSION 0.0.${PATCH_VERSION})

project(master VERSION ${PROJECT_VERSION})

include_directories(
    ${CMAKE_SOURCE_DIR}/include
)

configure_file(
    ${CMAKE_SOURCE_DIR}/version.h.in
    ${CMAKE_SOURCE_DIR}/include/version.h
)

option(USE_CPP23 "Enable C++23" OFF)
option(BUILD_GTEST "Build GTests" OFF)

set(CMAKE_CXX_STANDARD 20)
if(USE_CPP23)
    set(CMAKE_CXX_STANDARD 23)
endif()
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(include)
add_subdirectory(src)

if(BUILD_GTEST)
    add_subdirectory(googletest)
    enable_testing()
    add_subdirectory(ut)
endif()

set(CPACK_GENERATOR DEB)
set(CPACK_PROJECT_VERSION_MAJOR 0)
set(CPACK_PROJECT_VERSION_MINOR 0)
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_PACKAGE_CONTACT m.nartov24@yandex.ru)
include(CPack)