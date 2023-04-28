class User{
  String role = "";
  String displayedName = "";
  String username = "";
  String key = "";
  String phoneNumber = "";

  User();

  static List<User> passengers = [];

  User.fromMap(Map<String, dynamic> data) {
    role = data['role'] ?? "";
    username = data['username'] ?? "";
    displayedName = data['displayed_name'] ?? "";
    key = data['user_key'] ?? "";
    phoneNumber = data['phone_number'] ?? "";
  }

  static void parseToList(Map<String, dynamic> input, List<User> list) {
    Map<String, dynamic> jsonMap = input;
    List<dynamic> userList = jsonMap['passengers'];
    list.clear();

    for (Map<String, dynamic> userMap in userList) {
      User user = User();
      user.displayedName = userMap['displayed_name'].toString();
      user.phoneNumber = userMap['phone_number'].toString();
      list.add(user);
    }
  }
}