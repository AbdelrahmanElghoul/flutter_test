import 'package:test_flutter/data/fake_repository.dart';

abstract class IRepository {
  factory IRepository.production() => throw UnimplementedError();

  factory IRepository.fake() => FakeRepository();

  Future login({required String email, required String password});
}
