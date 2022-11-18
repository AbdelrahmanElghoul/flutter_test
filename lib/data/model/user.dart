import 'package:equatable/equatable.dart';
import 'package:test_flutter/data/model/user_address.dart';

class User extends Equatable {
  final String? _firstName;
  final String? _lastName;
  final String? _email;

  final Address? _address;
  const User({
    String? firstName,
    String? lastName,
    String? email,
    Address? address,
  })  : _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _address = address;

  String getFullName() {
    return "$_firstName $_lastName";
  }

  String? get email => _email;
  Address? get address => _address;

  @override
  String toString() {
    return 'User{firstName: $_firstName, lastName: $_lastName, email: $_email, address: $_address}';
  }

  @override
  List<Object?> get props => [email];
}
