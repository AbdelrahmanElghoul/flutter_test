import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  final String? message;

  const BaseException([this.message]);

  @override
  String toString() {
    return message ?? runtimeType.toString();
  }

  @override
  List<Object?> get props => [runtimeType];
}

class AuthException extends BaseException {
  final int? code;

  const AuthException({this.code, String? message}) : super(message);
}

class HomeException extends BaseException {
  const HomeException([super.message]);
}

class UnknownException extends BaseException {
  final Object? stackTrace;

  const UnknownException([this.stackTrace]);
}
