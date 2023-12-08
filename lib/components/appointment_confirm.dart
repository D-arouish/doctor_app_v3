// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../main_layout.dart';
import '../utils/config.dart';



class ConfirmationPage extends StatefulWidget {
  final DateTime selectedDate;
  final int selectedTime;
  final int selectedMin;
  final String fName;
  final String lName;
  final String cin;
  final String phoneNumber;
  final String doctorName;
  //final String email;

  // ignore: use_key_in_widget_constructors
  const ConfirmationPage({
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedMin,
    required this.fName,
    required this.lName,
    required this.cin,
    required this.phoneNumber,
    required this.doctorName,
  //  required this.email,
  });

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: const Text(
            'Appointment Confirmation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 240, 231, 231),
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                Text(
                  "Appointment Details",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${widget.fName}  ${widget.lName}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Config.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "CIN: ${widget.cin}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Config.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                //Row(
                //  mainAxisAlignment: MainAxisAlignment.center,
                //  children: [
                //    const Icon(Icons.email_outlined),
                //    Text(
                //      widget.email,
                //      style: const TextStyle(
                //        fontSize: 20,
                //        color: Config.primaryColor,
                //      ),
                //    ),
                //  ],
                //),
                //const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone),
                    Text(
                      widget.phoneNumber,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Config.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Date: ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Config.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Time: ${widget.selectedTime}:${widget.selectedMin}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey[900],
                  ),
                ),
                const SizedBox(height: 60),



                ElevatedButton(
                  onPressed: () async{

                    // Create new appointment document in Firestore
                    await FirebaseFirestore.instance.collection('appointment').add({
                      'name': "${widget.fName} ${widget.lName}",
                      //$$$$$$$$$$$$$$$
                      'email' : "",
                      //$$$$$$$$$$$$$$$
                      'cin': widget.cin,
                      'phone': widget.phoneNumber,
                      'doctor': widget.doctorName,
                      'date': "${widget.selectedDate.day.toString().padLeft(2,'0')}-${widget.selectedDate.month.toString().padLeft(2,'0')}-${widget.selectedDate.year}",

                      //'date': "${widget.selectedDate.day}-${widget.selectedDate.month}-${widget.selectedDate.year}",
                      'time': '${widget.selectedTime}:${widget.selectedMin}',
                    //                 'email' : widget.email,
                    });
                    //sendEmailWithQRCode(
                    //    '${widget.fName} ${widget.lName}',
                    //    widget.phoneNumber,
                    //    " ${widget.selectedDate.day}-${widget.selectedDate.month}-${widget.selectedDate.year}",
                    //    '${widget.selectedTime}:${widget.selectedMin}',
                    //     widget.doctorName,
                    //    widget.email
                    //);

                    // Show a snackbar message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Appointment confirmed!'),backgroundColor: Colors.green,),
                    );
// Navigate to confirmation page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainLayout(),
                      ),
                    );
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Config.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
