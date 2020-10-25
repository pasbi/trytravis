cmake_minimum_required (VERSION 3.3)  # warnings vanish with Version > 3.3

project (ommpfritt VERSION 0.1.0)

set (CMAKE_AUTOMOC ON)
set (CMAKE_AUTORCC ON)
set (CMAKE_AUTOUIC ON)
set (QT_QM_PATH CACHE PATH
    "path where to find the Qt translation files (qt_en.qm, qtbase_de.qm, etc.")

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/src")
include_directories("${PROJECT_BINARY_DIR}")

find_package(PkgConfig)

find_package(PythonLibs 3 REQUIRED)
link_directories(${PythonLibs_LIBRARY_DIRS})
include_directories(${PythonLibs_INCLUDE_DIRS})

find_package(pybind11 REQUIRED)
link_directories(${pybind11_LIBRARY_DIRS})
include_directories(${pybind11_INCLUDE_DIRS})

ADD_DEFINITIONS(-DQT_NO_KEYWORDS)
find_package(Qt5Widgets CONFIG REQUIRED)
find_package(Qt5Svg REQUIRED)
find_package(Qt5 COMPONENTS LinguistTools)

find_package(KF5ItemModels REQUIRED)

qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})

foreach (lang de en es)
  foreach (pref qt qtbase qt_help qtlocation)
    file(COPY ${QT_QM_PATH}/${pref}_${lang}.qm DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
  endforeach(pref)
endforeach(lang)

add_library(libommpfritt)

add_executable(ommpfritt ${RESOURCES})

target_compile_features(libommpfritt PUBLIC cxx_std_17)
target_compile_features(ommpfritt PUBLIC cxx_std_17)

target_link_libraries(libommpfritt ${PYTHON_LIBRARIES})
target_link_libraries(ommpfritt ${PYTHON_LIBRARIES})
target_include_directories(libommpfritt PRIVATE ${PYTHON_INCLUDE_DIRS})
target_link_libraries(libommpfritt pybind11::embed)
target_link_libraries(ommpfritt pybind11::embed)
target_link_libraries(libommpfritt Qt5::Widgets Qt5::Svg)
target_link_libraries(ommpfritt Qt5::Widgets Qt5::Svg)
target_link_libraries(libommpfritt poppler-qt5)
target_link_libraries(ommpfritt poppler-qt5)
target_link_libraries(libommpfritt -lpthread -lm -ldl)
target_link_libraries(ommpfritt -lpthread -lm -ldl)
target_link_libraries(libommpfritt KF5ItemModels)
target_link_libraries(ommpfritt KF5ItemModels)

add_subdirectory(src)
add_subdirectory(test)

target_link_libraries(ommpfritt libommpfritt)

install(TARGETS ommpfritt RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib/static)
install(TARGETS libommpfritt RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib/static)

include(CPack)
if (MINGW)
  message(STATUS "  Installing system libraries mingw dll")
  get_filename_component(MinGWPath ${CMAKE_CXX_COMPILER} PATH)
  message(STATUS "mingw path: ${MinGWPath}")
  set(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS
      ${MinGWPath}/libbrotlicommon.dll
      ${MinGWPath}/libbrotlidec.dll
      ${MinGWPath}/libbz2-1.dll
      ${MinGWPath}/libdouble-conversion.dll
      ${MinGWPath}/libfreetype-6.dll
      ${MinGWPath}/libgcc_s_seh-1.dll
      ${MinGWPath}/libglib-2.0-0.dll
      ${MinGWPath}/libgraphite2.dll
      ${MinGWPath}/libharfbuzz-0.dll
      ${MinGWPath}/libiconv-2.dll
      ${MinGWPath}/libicudt67.dll
      ${MinGWPath}/libicuin67.dll
      ${MinGWPath}/libicuuc67.dll
      ${MinGWPath}/libintl-8.dll
      ${MinGWPath}/libpcre-1.dll
      ${MinGWPath}/libpcre2-16-0.dll
      ${MinGWPath}/libpng16-16.dll
      ${MinGWPath}/libstdc++-6.dll
      ${MinGWPath}/libwinpthread-1.dll
      ${MinGWPath}/libzstd.dll
      ${MinGWPath}/Qt5Core.dll
      ${MinGWPath}/Qt5Gui.dll
      ${MinGWPath}/Qt5Widgets.dll
      ${MinGWPath}/Qt5WinExtras.dll
      ${MinGWPath}/zlib1.dll
      )
      install(FILES ${MinGWPath}/../share/qt5/plugins/platforms/qwindows.dll DESTINATION bin/platforms)
endif()
include(InstallRequiredSystemLibraries)
