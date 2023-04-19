class User{
  String role = "";
  String displayedName = "";
  String username = "";
  String key = "";
  String phoneNumber = "";

  User();

  User.fromMap(Map<String, dynamic> data) {
    role = data['role'];
    username = data['username'];
    displayedName = data['displayed_name'];
    key = data['user_key'];
    phoneNumber = data['phone_number'];
  }
}