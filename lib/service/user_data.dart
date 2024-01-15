class UserData {
  static String uid = "";
  static String userName = "";
  static String email = "";
  static String image = "";
  static String tel = "";
  static List<String> accountType = ["Email", "Google", "Facebook", "Line"];
  static int loginType = 0;

  static clear() {
    uid = "";
    userName = "";
    email = "";
    image = "";
    tel = "";
  }
}
