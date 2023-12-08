import 'package:doctor_app_v3/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}
String? name;
String? date;
String? time;
String? phone;
String? doctorName;




class _ScannerPageState extends State<ScannerPage> {
  var getResult = 'QR Code Result';
  bool isResultAvailable = false; // added variable to track if result is available

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromARGB(0, 1, 1, 1),
        elevation: 0,
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Config.primaryColor)),
              onPressed: () {
                scanQRCode();
              },
              child: Text('Scan QR Code'),
            ),
            SizedBox(height: 20.0,),
            Text(getResult),
          ],
        ),
      ),
      bottomNavigationBar: isResultAvailable ? // conditional rendering of button
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
        child: Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Config.primaryColor)),
            onPressed: () {
              Navigator.pop(context, {
                'name': name,
                'date': date,
                'doctorName': doctorName,
                'time' : time,
              });
              // add logic to navigate to appointment search page
            },
            child: Text('Search Appointments'),
          ),
        ),
      ) : null, // set bottomNavigationBar to null if result is not available
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;
      List<String> qrDataParts = qrCode.split('\n');
      name = qrDataParts[0]; // get name from the first item in the list
      date = qrDataParts[1]; // get date from the second item in the list
      time = qrDataParts[2]; // get time from the third item in the list
      phone = qrDataParts[3]; // get phone from the fourth item in the list
      doctorName = qrDataParts[4]; // get doctor name from the fifth item in the list
      setState(() {
        getResult = qrCode;
        isResultAvailable = true; // set result availability to true
        // Extract data from QR code
      });
      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      setState(() {
        getResult = 'Failed to scan QR Code.';
        isResultAvailable = false; // set result availability to false
      });
    }
  }
}
