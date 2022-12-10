import 'package:mockito/annotations.dart';
import 'package:test_flutter/data/model/excception_model/exceptions.dart';
import 'package:test_flutter/data/model/location.dart';
import 'package:test_flutter/data/model/user.dart';
import 'package:test_flutter/data/model/user_address.dart';
import 'package:test_flutter/data/repo_interface.dart';

@GenerateNiceMocks([MockSpec<FakeRepository>()])
class FakeRepository implements IRepository {
  static const String fakeEmail = 'test0@test.com';
  static const String fakePassword = 'Ab123456';

  FakeRepository._();

  static FakeRepository instance = FakeRepository._();

  @override
  Future login({required String? email, required String? password}) async {
    assert(email != null && password != null);
    await Future.delayed(const Duration(seconds: 5));

    if (email == fakeEmail && password == fakePassword) {
      return const User(
        firstName: "FN",
        lastName: "LN",
        email: fakeEmail,
        address: Address(
          address: "dummy address for test",
          location: Location(31, 30),
        ),
      );
    }

    throw const AuthException(message: 'email or password incorrect');
  }

  @override
  Future getUsers() async {
    return List.generate(
      100,
      (index) => User(
        firstName: "0x_${index}_firstName",
        lastName: "1x_${index}_lastName",
        email: "user_$index@test.com",
        address: Address(
          address: "$index street",
          location: Location(index, index),
        ),
      ),
    );
  }
}
