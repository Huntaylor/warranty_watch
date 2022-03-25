import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () => context.pop(),
        //   icon: const Icon(
        //     Icons.arrow_back,
        //   ),
        // ),
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: Text(
          'this is the sign up view.',
        ),
      ),
    );
  }
}
