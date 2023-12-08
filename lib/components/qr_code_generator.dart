import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ClientQRCode extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final String phone;
  final String doctorName;



  ClientQRCode({required this.name, required this.phone, required this.date, required this.time, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    String qrData = "Name: $name\nDate: $date\nTime: $time\nPhone: $phone\nDoctor: $doctorName";
    return Container(
      padding: EdgeInsets.all(20.0),
      child: QrImage(
        data: qrData,
        version: QrVersions.auto,
        size: 200.0,
      ),
    );
  }
}
