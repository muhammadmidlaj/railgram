import 'package:email_validator/email_validator.dart';

class FormValidator {
  bool isPasswordValid(String password) => password.length < 6;

  bool isEmailValid(String email) => EmailValidator.validate(email);

  bool isContentValid(String content) => content.length < 20;

  bool isTitleValid(String title) => title.length < 10;
}
