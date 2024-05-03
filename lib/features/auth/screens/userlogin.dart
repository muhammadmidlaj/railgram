import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/auth/services/auth_service.dart';

import 'package:railgram/widgets/textfield.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final AuthService authService = AuthService();
  final TextEditingController _loginUserNameController =
      TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signIn() {
    authService.signInUser(
        context: context,
        username: _loginUserNameController.text.trim(),
        password: _loginPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Login',
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
                                  controller: _loginUserNameController,
                                  icon: Icons.person,
                                  txthint: 'UserName',
                                  obscure: false),
                              TextFieldWidget(
                                  controller: _loginPasswordController,
                                  icon: Icons.lock,
                                  txthint: ' Password',
                                  obscure: true)
                            ],
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signIn();
                              }
                            },
                            child: const Text('Login')),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, '/register'),
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
                                  "Don't Have an Account ? Register",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
