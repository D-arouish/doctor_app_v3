
import "package:flutter/material.dart";

import "../utils/config.dart";



void main() {
  // For debugging layout issues
  // debugPaintSizeEnabled = true;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14.0),
        ),
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              child: const Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  CircleAvatar(
                    radius: 65.0,
                    backgroundImage: AssetImage('assets/images/x.png'),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Amanda Tan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'ophthalmologist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
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
                                Icons.person,
                                color: Colors.blueAccent[400],
                                size: 35,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Profile",
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
                                onPressed: () {},
                                child: const Text(
                                  "History",
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
                                 //logOut function***************************************
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