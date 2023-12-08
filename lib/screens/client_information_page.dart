import 'package:flutter/material.dart';


import '../utils/config.dart';
import '../components/appointment_confirm.dart';

//import 'Client.dart';
//import 'PhoneVerificationPage.dart';

class ClientInformation extends StatelessWidget {
  final DateTime selectedDate;
  final int selectedTime;
  final int selectedMin;
  final String doctorName;

  final TextEditingController controllerFName = TextEditingController();
  final TextEditingController controllerLName = TextEditingController();
  final TextEditingController controllerID = TextEditingController();
  final TextEditingController controllerPhoneNumber = TextEditingController();
  //final TextEditingController controllerEmail = TextEditingController();

  ClientInformation({Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedMin,
    required this.doctorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Client Information's"),
        foregroundColor: Config.primaryColor,
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.person_outline),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controllerFName,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                      label: Text("First Name"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Config.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controllerLName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      label: Text("Last Name"),
                      hintText: "Last Name",
                      labelStyle: TextStyle(
                        color: Config.primaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Icon(Icons.credit_card),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controllerID,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      label: Text("CIN"),
                      hintText: "CIN",
                      labelStyle: TextStyle(
                        color: Config.primaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //Row(
            //  children: <Widget>[
            //    const Icon(Icons.email_outlined),
            //    const SizedBox(width: 10),
            //    Expanded(
            //      child: TextField(
            //        controller: controllerEmail,
            //        decoration: const InputDecoration(
            //          border: OutlineInputBorder(
            //            borderSide: BorderSide(width: 2),
            //            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //          ),
            //          label: Text("Email"),
            //          hintText: "Email",
            //          labelStyle: TextStyle(
            //            color: Config.primaryColor,
            //            fontWeight: FontWeight.normal,
            //            fontSize: 20,
            //          ),
            //        ),
            //        keyboardType: TextInputType.emailAddress,
            //      ),
            //    ),
            //  ],
            //),
            //const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Icon(Icons.phone),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controllerPhoneNumber,
                    decoration: const InputDecoration(
                      prefixText: "+212  ",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      label: Text("Phone Number"),
                      hintText: "xxxxxxxxx",
                      labelStyle: TextStyle(
                        color: Config.primaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (controllerFName.text.isNotEmpty &&
                        controllerLName.text.isNotEmpty &&
                        controllerID.text.isNotEmpty &&
                        controllerPhoneNumber.text.isNotEmpty
 //                     && controllerEmail.text.isNotEmpty
                    ) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(
                            doctorName: doctorName,
                            selectedMin: selectedMin,
                            lName: controllerLName.text,
                            phoneNumber: controllerPhoneNumber.text,
                            cin: controllerID.text,
                            fName: controllerFName.text,
                            selectedTime: selectedTime,
                            selectedDate: selectedDate,
                            //email: controllerEmail.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Config.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "save",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
