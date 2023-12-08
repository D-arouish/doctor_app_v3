import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _name = '';
  String _date = '';
  String _time = '';
  String _phone = '';
  String _doctorName = '';
  Uint8List? _qrCodeBytes;

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _doctorNameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _phoneController.dispose();
    _doctorNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Generator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Code Generator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => setState(() => _name = value),
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                onChanged: (value) => setState(() => _date = value),
              ),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time'),
                onChanged: (value) => setState(() => _time = value),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                onChanged: (value) => setState(() => _phone = value),
              ),
              TextField(
                controller: _doctorNameController,
                decoration: InputDecoration(labelText: 'Doctor Name'),
                onChanged: (value) => setState(() => _doctorName = value),
              ),
              ElevatedButton(
                onPressed: () => _generateQRCode(),
                child: Text('Generate QR Code'),
              ),
              if (_qrCodeBytes != null) ...[
                SizedBox(height: 16),
                Expanded(
                  child: Image.memory(_qrCodeBytes!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generateQRCode() async {
    final qrData = "$_name\n$_date\n$_time\n$_phone\n$_doctorName";
    final qrCode = QrCode.fromData(data: qrData, errorCorrectLevel: QrErrorCorrectLevel.Q);
    final painter = QrPainter(data: qrData,version: QrVersions.auto);
    final size = 200.0;
    final image = await painter.toImageData(size);
    setState(() => _qrCodeBytes = image?.buffer.asUint8List());
  }
}
