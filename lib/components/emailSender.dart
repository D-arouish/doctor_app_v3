import 'dart:io';
import 'dart:ui';


import 'package:qr_flutter/qr_flutter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';



void sendEmailWithQRCode(name, phone, date, time, doctorName,email) async {
  // Generate the QR code data
  String qrData = "Name: $name\nDate: $date\nTime: $time\nPhone: $phone\nDoctor: $doctorName";

  // Create the QR code widget
  final qrCodeWidget = QrImage(
    data: qrData,
    version: QrVersions.auto,
    size: 200.0,
  );

  // Encode the QR code as a PNG image
  //final pngBytes = await qrCodeWidget.toByteData(Format.png);
  final qrPainter = QrPainter(
    data: qrData,
    version: QrVersions.auto,
    gapless: false,
  );
  final pngBytes = await qrPainter.toImageData(200,  format: ImageByteFormat.png);


  // Create an SMTP client to send the email
  final smtpServer = gmail('zackdarouich@gmail.com', 'Zack@Darouich@183461');

  // Create the email message
  final message = Message()
    ..from = const Address('zackdarouich@gmail.com')
    ..recipients.add(email)
    ..subject = 'Appointment QR Code'
    ..attachments.add(FileAttachment(
        File.fromRawPath(pngBytes!.buffer.asUint8List()),
        fileName: 'appointment_qr_code.png'
    ));

  // Send the email
  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } catch (e) {
    print('Error sending email: $e');
  }
}
