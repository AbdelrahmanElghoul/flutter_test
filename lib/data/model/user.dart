class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? token;

  User({this.id, this.firstName, this.lastName, this.email, this.token});

  String getFullName() {
    return "$firstName $lastName";
  }
}
