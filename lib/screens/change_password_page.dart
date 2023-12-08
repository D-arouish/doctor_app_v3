import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isProcessing = false;
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Config.primaryColor,
        backgroundColor: const Color.fromARGB(0, 1, 1, 1),
        elevation: 0,
        title: const Text('Change Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _oldPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Config.primaryColor,
                  obscureText: _obscureOldPassword,
                  decoration: InputDecoration(
                    labelText: 'Old Password',
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: Config.primaryColor,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureOldPassword = !_obscureOldPassword;
                            });
                          },
                          icon: _obscureOldPassword
                              ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                              : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  decoration:  InputDecoration(
                    labelText: 'New Password',
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: Config.primaryColor,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
                            });
                          },
                          icon: _obscureNewPassword
                              ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                              : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: Config.primaryColor,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                          icon: _obscureConfirmPassword
                              ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                              : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          )
                      )
                  ),
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                Config.spaceSmall,
                ElevatedButton(
                  onPressed: _isProcessing ? null : _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[900],
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isProcessing
                      ? const CircularProgressIndicator()
                      : const Text('Change Password'),
                ),
              ],
            ),
          ),
        ),
      ),
      );

  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updatePassword(_newPasswordController.text);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password changed successfully.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to change password: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to change password'),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _isProcessing = false;
      });
    }
  }
}
