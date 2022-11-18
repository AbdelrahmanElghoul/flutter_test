import 'package:test_flutter/data/model/user_address.dart';

class User {
  String? firstName;
  String? lastName;
  String? email;

  Address? address;
  User({this.firstName, this.lastName, this.email, this.address});

  String getFullName() {
    return "$firstName $lastName";
  }
}
