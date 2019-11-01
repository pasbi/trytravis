
file(GLOB SOURCES
  mainwindow.cpp
)

file(GLOB HEADERS
  mainwindow.h
)

target_sources(libommpfritt PRIVATE ${SOURCES} ${HEADERS})

