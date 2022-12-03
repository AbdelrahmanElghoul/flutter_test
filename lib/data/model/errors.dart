import 'package:equatable/equatable.dart';

class AuthException extends Equatable implements Exception {
  final String? message;

  const AuthException([this.message]);

  @override
  String toString() {
    return message ?? runtimeType.toString();
  }

  @override
  List<Object?> get props => [runtimeType];
}
