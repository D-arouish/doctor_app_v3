import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/login_form.dart';
import '../utils/config.dart';
import '../utils/text.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  bool isSignIn = true;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    //build login text field
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppText.enText['welcome_text']!,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,

            //logo

            Text(
              AppText.enText['signIn_text']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            LoginForm(emailController: emailController),
            Config.spaceSmall,
            Center(
              child: TextButton(
                onPressed: () async {
                  final email = emailController.text;
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Password reset email sent')));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Error sending password reset email')));
                  }
                },
                child: Text(
                  AppText.enText['forgot-password']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Spacer(),

            Config.spaceSmall,
          ],
        ),
      ),
    ));
  }
}
