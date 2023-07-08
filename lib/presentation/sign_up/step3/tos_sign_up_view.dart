import 'package:flutter/material.dart';

class TosSignUpView extends StatelessWidget {
  const TosSignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tos sign up'),
      ),
      body: const Center(
        child: Text(
          'this is the tos sign up.',
        ),
      ),
    );
  }
}
