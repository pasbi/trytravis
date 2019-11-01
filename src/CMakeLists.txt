
file(GLOB SOURCES
  main.cpp
)

file(GLOB HEADERS
)

add_subdirectory(mainwindow)

target_sources(libommpfritt PRIVATE ${SOURCES} ${HEADERS})

