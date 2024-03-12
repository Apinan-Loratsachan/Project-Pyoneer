

// ignore_for_file: avoid_print

class PyoneerLog {
  static void printBlack(String text) {
    print('\x1B[30m$text\x1B[0m');
  }

  static void printRed(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  static void printGreen(String text) {
    print('\x1B[32m$text\x1B[0m');
  }

  static void printYellow(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  static void printBlue(String text) {
    print('\x1B[34m$text\x1B[0m');
  }

  static void printMagenta(String text) {
    print('\x1B[35m$text\x1B[0m');
  }

  static void printCyan(String text) {
    print('\x1B[36m$text\x1B[0m');
  }

  static void printWhite(String text) {
    print('\x1B[37m$text\x1B[0m');
  }
}
