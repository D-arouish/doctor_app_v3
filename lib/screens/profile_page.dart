import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? doctorName;
  String? moreInfo;
  String? speciality;
  String? profileImage;
  NetworkImage? networkImage;

  void initState() {
    super.initState();
    // Call the method to fetch the doctor name from Firestore when the widget is initialized.
    getDoctorName();
  }

  /*
  @override

  void initState() {
    super.initState();
    // Get doctor name from Firestore
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        setState(() {
          doctorName = doc.data()!['name'];
        });
      } else {
        print('Document does not exist on the database');
      }
    }).catchError((error) {
      print('Error getting document: $error');
    });
  }

   */

  Future<void> getDoctorName() async {
    try {
      // Get the Firestore instance and reference to the document that contains the doctor's information.
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference documentReference = firestore
          .collection('doctors')
          .doc(FirebaseAuth.instance.currentUser?.uid);

      // Fetch the document data.
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Extract the doctor name from the document data.
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          doctorName = data['name'];
          profileImage = data['imageUrl'];
          networkImage = NetworkImage(profileImage!);
          moreInfo = data['additionalInfo'];
          speciality = data['speciality'];
        });
      }
    } catch (e) {
      // Handle errors.
      print('Failed to get doctor name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: Config.primaryColor,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 80,
                  ),

                  CircleAvatar(
                    radius: 65.0,
                    backgroundImage: networkImage != null
                        ? NetworkImage(profileImage!)
                        : const AssetImage('assets/images/x.png')
                            as ImageProvider,
                    backgroundColor: Colors.white,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    doctorName ?? 'Loading...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    speciality ?? '...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.grey[200],
              child: Center(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.settings,
                                color: Colors.blueAccent[400],
                                size: 35,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('settings_page');
                                },
                                child: const Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    color: Config.primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Config.spaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.lock_outline,
                                color: Colors.yellowAccent[400],
                                size: 35,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('change_password_page');
                                },
                                child: const Text(
                                  "Change Password",
                                  style: TextStyle(
                                    color: Config.primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Config.spaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.logout_outlined,
                                color: Colors.lightGreen[400],
                                size: 35,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseAuth.instance.signOut();
                                    // redirect to home page
                                    Navigator.of(context)
                                        .pushReplacementNamed('auth_page');
                                  } catch (e) {
                                    // handle errors
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Failed to sign Out. Please check your internet connection'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Config.primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
