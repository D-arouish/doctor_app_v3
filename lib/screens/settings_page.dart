import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v3/utils/config.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  final String doctorUID = FirebaseAuth.instance.currentUser!.uid;

  //final String uid = FirebaseAuth.instance.currentUser!.uid;

  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  //final _nameController = TextEditingController();
  //final _phoneController = TextEditingController();
  final _aboutController = TextEditingController();

  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Config.primaryColor,
        backgroundColor: const Color.fromARGB(0, 1, 1, 1),
        elevation: 0,
        title: const Text('       Profile Information'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //TextFormField(
                //  controller: _nameController,
                //  decoration: const InputDecoration(
                //    labelText: 'Name',
                //  ),
                //  validator: (value) {
                //    if (value == null || value.isEmpty) {
                //      return 'Please enter your first name';
                //    }
                //    return null;
                //  },
                //),
                const SizedBox(height: 20),
               //TextFormField(
               //  controller: _phoneController,
               //  keyboardType: TextInputType.phone,
               //  decoration: const InputDecoration(
               //    labelText: 'Phone Number',
               //  ),
               //  validator: (value) {
               //    if (value == null || value.isEmpty) {
               //      return 'Please enter your phone number';
               //    }
               //    return null;
               //  },
               //),
               // const SizedBox(height: 20),
                TextFormField(
                  controller: _aboutController,
                  decoration: const InputDecoration(
                    labelText: 'About',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your *******';
                    }
                    return null;
                  },
                  maxLines: 10, // Maximum number of lines allowed
                  minLines: 5, // Minimum number of lines to occupy
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? doctor = FirebaseAuth.instance.currentUser;
                      if (doctor != null) {
// Update user data in the Firestore database
                        await FirebaseFirestore.instance
                            .collection('doctors')
                            .doc(doctor.uid)
                            .update({
                         // 'name': _nameController.text,
                         // 'phoneNumber': _phoneController.text,
                          'additionalInfo': _aboutController.text
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('User information updated')));
                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Config.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Update Info'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
