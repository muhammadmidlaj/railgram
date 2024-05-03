import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String txthint;
  final bool obscure;

  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.icon,
      required this.txthint,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: Colors.blue,
          ),
          hintText: txthint,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your $txthint';
          }
          return null;
        },
      ),
    );
  }
}
