import 'package:test_flutter/data/repo_interface.dart';

class FakeRepository implements IRepository {
  static const String fakeEmail = 'test0@test.com';
  static const String fakePassword = 'Ab123456';
  @override
  Future login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 5));

    if (email == fakeEmail && password == fakePassword) return "success";

    throw Exception('invalid data');
  }
}
