import 'package:flutter/foundation.dart';

class PyoneerLog {
  static void black(String text) {
    if (kDebugMode) {
      print('\x1B[30m$text\x1B[0m');
    }
  }

  static void red(String text) {
    if (kDebugMode) {
      print('\x1B[31m$text\x1B[0m');
    }
  }

  static void green(String text) {
    if (kDebugMode) {
      print('\x1B[32m$text\x1B[0m');
    }
  }

  static void yellow(String text) {
    if (kDebugMode) {
      print('\x1B[33m$text\x1B[0m');
    }
  }

  static void blue(String text) {
    if (kDebugMode) {
      print('\x1B[34m$text\x1B[0m');
    }
  }

  static void magenta(String text) {
    if (kDebugMode) {
      print('\x1B[35m$text\x1B[0m');
    }
  }

  static void cyan(String text) {
    if (kDebugMode) {
      print('\x1B[36m$text\x1B[0m');
    }
  }

  static void white(String text) {
    if (kDebugMode) {
      print('\x1B[37m$text\x1B[0m');
    }
  }

  static void violet(String text) {
    if (kDebugMode) {
      print('\x1B[35m$text\x1B[0m');
    }
  }

  static void purple(String text) {
    if (kDebugMode) {
      print('\x1B[35m$text\x1B[1;35m');
    }
  }

  static void lightBlue(String text) {
    if (kDebugMode) {
      print('\x1B[36m$text\x1B[1;36m');
    }
  }

  static void teal(String text) {
    if (kDebugMode) {
      print('\x1B[36m$text\x1B[0;36m');
    }
  }

  static void amber(String text) {
    if (kDebugMode) {
      print('\x1B[33m$text\x1B[1;33m');
    }
  }

  static void azure(String text) {
    if (kDebugMode) {
      print('\x1B[34m$text\x1B[1;34m');
    }
  }

  static void crimson(String text) {
    if (kDebugMode) {
      print('\x1B[31m$text\x1B[1;31m');
    }
  }

  static void lime(String text) {
    if (kDebugMode) {
      print('\x1B[32m$text\x1B[1;32m');
    }
  }

// Add more color functions here
}
