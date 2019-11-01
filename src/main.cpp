#include "mainwindow/mainwindow.h"
#include <QApplication>

int main (int argc, char *argv[])
{
  QApplication qt_app(argc, argv);
  omm::MainWindow window;
  window.show();

  return qt_app.exec();
}
