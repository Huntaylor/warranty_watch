import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('forgot password view'),
      ),
      body: const Center(
        child: Text(
          'this is the forgot password view.',
        ),
      ),
    );
  }
}
