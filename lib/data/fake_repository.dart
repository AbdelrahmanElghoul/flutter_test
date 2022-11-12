import 'package:test_flutter/data/repo_interface.dart';

class FakeRepository implements IRepository {
  @override
  Future login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 5));

    if (email == 'test@test.com' && password == "Ab123456") return "success";

    throw Exception('invalid data');
  }
}
