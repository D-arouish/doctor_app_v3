import 'package:doctor_app_v3/services/appointment_page_test.dart';
import 'package:doctor_app_v3/screens/booking_page.dart';
import 'package:doctor_app_v3/screens/profile_page.dart';
import 'package:doctor_app_v3/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  //variable declaration
  int currentPage = 0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: <Widget>[
          const BookingPage(),
          const AppointmentPage(),
          //const ScannerPage(),
          //const NotificationPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Config.primaryColor,
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.houseMedical),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
            label: 'Appointments',
          ),
          //BottomNavigationBarItem(
          //  icon: FaIcon(FontAwesomeIcons.qrcode),
          //  label: 'Scanner',
          //),
          /*
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bell),
            label: 'Notifications',
          ),
          */

          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userDoctor),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}