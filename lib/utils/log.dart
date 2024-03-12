

// ignore_for_file: avoid_print

class PyoneerLog {
  static void black(String text) {
    print('\x1B[30m$text\x1B[0m');
  }

  static void red(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  static void green(String text) {
    print('\x1B[32m$text\x1B[0m');
  }

  static void yellow(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  static void blue(String text) {
    print('\x1B[34m$text\x1B[0m');
  }

  static void magenta(String text) {
    print('\x1B[35m$text\x1B[0m');
  }

  static void cyan(String text) {
    print('\x1B[36m$text\x1B[0m');
  }

  static void white(String text) {
    print('\x1B[37m$text\x1B[0m');
  }

  static void violet(String text) {
  print('\x1B[35m$text\x1B[0m');
}

static void purple(String text) {
  print('\x1B[35m$text\x1B[1;35m');
}

static void LightBlue(String text) {
  print('\x1B[36m$text\x1B[1;36m');
}

static void Teal(String text) {
  print('\x1B[36m$text\x1B[0;36m');
}

static void Amber(String text) {
  print('\x1B[33m$text\x1B[1;33m');
}

static void Azure(String text) {
  print('\x1B[34m$text\x1B[1;34m');
}

static void Crimson(String text) {
  print('\x1B[31m$text\x1B[1;31m');
}

static void Lime(String text) {
  print('\x1B[32m$text\x1B[1;32m');
}

// Add more color functions here

}
