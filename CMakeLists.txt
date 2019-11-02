cmake_minimum_required (VERSION 2.8.4)  # warnings vanish with Version > 3.3

project (ommpfritt)

set (CMAKE_AUTOMOC ON)
set (CMAKE_AUTORCC ON)
set (CMAKE_AUTOUIC ON)
set (OMMPFRITT_VERSION_MAJOR 1)
set (OMMPFRITT_VERSION_MINOR 0)

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/src")
include_directories("${PROJECT_BINARY_DIR}")

find_package(PkgConfig)

find_package(PythonLibs 3 REQUIRED)
link_directories(${PythonLibs_LIBRARY_DIRS})
include_directories(${PythonLibs_INCLUDE_DIRS})

ADD_DEFINITIONS(-DQT_NO_KEYWORDS)
find_package(Qt5Widgets CONFIG REQUIRED)
find_package(Qt5Svg REQUIRED)
find_package(Qt5 COMPONENTS LinguistTools)

find_package(KF5ItemModels REQUIRED)

add_library(libommpfritt)

add_executable(ommpfritt ${RESOURCES})

target_compile_features(libommpfritt PUBLIC cxx_std_17)
target_compile_features(ommpfritt PUBLIC cxx_std_17)

target_link_libraries(libommpfritt Qt5::Widgets Qt5::Svg)
target_link_libraries(ommpfritt Qt5::Widgets Qt5::Svg)
target_link_libraries(libommpfritt poppler-qt5)
target_link_libraries(ommpfritt poppler-qt5)
target_link_libraries(libommpfritt -lpthread -lm -ldl -lutil)
target_link_libraries(ommpfritt -lpthread -lm -ldl -lutil)
target_link_libraries(libommpfritt KF5ItemModels)
target_link_libraries(ommpfritt KF5ItemModels)

add_subdirectory(src)
add_subdirectory(test)

target_link_libraries(ommpfritt libommpfritt)

install(TARGETS ommpfritt RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib/static)
install(TARGETS libommpfritt RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib/static)
