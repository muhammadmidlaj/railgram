import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/constants/validation.dart';
import 'package:railgram/features/auth/services/auth_service.dart';
import 'package:railgram/widgets/textfield.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final AuthService authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordconfirmController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FormValidator _formValidator = FormValidator();

  void userSignup() {
    print('object');
    authService.signUpUser(
        context: context,
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: primaryColor,
          border: Border(),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            Expanded(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Register',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFieldWidget(
                                controller: _usernameController,
                                icon: Icons.person,
                                txthint: 'username',
                                obscure: false),
                            TextFieldWidget(
                                controller: _emailController,
                                icon: Icons.mail,
                                txthint: 'e-mail',
                                obscure: false),
                            TextFieldWidget(
                                controller: _passwordController,
                                icon: Icons.lock,
                                txthint: 'password',
                                obscure: true),
                            TextFieldWidget(
                                controller: _passwordconfirmController,
                                icon: Icons.lock,
                                txthint: 'password',
                                obscure: true)
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            var isPasswordValidated = _formValidator
                                .isPasswordValid(_passwordController.text);
                            var isEmailValidated = _formValidator
                                .isEmailValid(_emailController.text);
                            if (_formKey.currentState!.validate()) {
                              if (_passwordController.text !=
                                  _passwordconfirmController.text) {
                                showSnackBar(context, 'Password do not mstch');
                              } else {
                                if (!isEmailValidated) {
                                  showSnackBar(
                                      context, 'check your mail address');
                                } else if (isPasswordValidated) {
                                  showSnackBar(context,
                                      'The password field must be at least 6 characters long');
                                } else {
                                  userSignup();
                                }
                              }
                            }

                            //userSignup();
                          },
                          child: const Text('Register')),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, '/login'),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          alignment: Alignment.bottomCenter,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Already have an Account ? Login',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 249, 249, 249)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
