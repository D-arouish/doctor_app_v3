import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/config.dart';
import 'button.dart';



class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  const LoginForm({Key? key, required this.emailController}) : super(key: key);


  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  bool obsecurePass = true;





  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.black38,
                    )
                        : const Icon(
                      Icons.visibility_outlined,
                      color: Config.primaryColor,
                    ))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          Button(
            width:double.infinity,
            title: 'Sign In',
            onPressed: _signIn,
            disable: false,
          ),
              ],
      ),

          );



  }
//C:\Program Files\Java\jdk-18.0.1.1

  void _signIn() async {
    print(("_signIn invoked"));
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: widget.emailController.text,
          password: _passwordController.text,
        );
        print("signed In correctly");
        // redirect to home page
        Navigator.of(context).pushNamed('main');
      } catch (e) {
        // handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to sign in.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}





