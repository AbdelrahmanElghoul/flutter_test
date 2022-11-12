abstract class Validation {
  static bool email(String email) {
    return RegExp(
            r"^[a-zA-Z][a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool password(String? password) {
    return (password ?? '').trim().length >= 6;
  }
}
