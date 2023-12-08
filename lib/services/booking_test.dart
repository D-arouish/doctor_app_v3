import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


import '../utils/config.dart';



class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(0, 1, 1, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person_add_alt_outlined),
          onPressed: () {
            // Do something when the icon button is pressed

          },
        ),
        foregroundColor: Colors.black,
        title: const Center(child: Text('Appointments',style: TextStyle(fontSize: 25),)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_outlined),
            onPressed: () {
              _scanQRCode();
              //Navigator.of(context).pushNamed('qr_scanner_page');
              // Do something when the icon button is pressed
            },
          ),
        ],

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 10, right: 8),
          child: ClientListPage(),
        ),
      ),
    );
  }
}
final clients = [
  Client(name: 'John Doe',date: '15-05-2023',time: '02:15'),
  Client(name: 'Jane Doe',date: '15-05-2023',time: '02:00'),
  Client(name: 'Bob Smith',date: '15-05-2023',time: '02:15'),
];

class ClientListPage extends StatefulWidget {


  ClientListPage({Key? key}) : super(key: key);

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients.elementAt(index);

        return ClientCard(client: client);
      },
    );
  }
}

class Client {
  final String name;
  final String date;
  final String time;

  Client({required this.name,required this.date,required this.time});
}

class ClientCard extends StatefulWidget {
  final Client client;

  const ClientCard({Key? key, required this.client}) : super(key: key);

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  late Client client;

  @override
  void initState() {
    super.initState();
    client = widget.client;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(80, 12, 14, 75),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/x.png"),
                  ),
                ),
                Config.spaceSmall,
                Text(
                  widget.client.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            ScheduleCard(date: client.date, time: client.time),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        // Change the status of the client to "Complete"
                        client.status = 'Complete';
                      });
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                */
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        clients.remove(client);
                        // Change the status of the client to "Cancel"
                        //client.status = 'Cancel';

                      });
                    },

                    child: const Text(
                      'Complete',
                      style: TextStyle(color: Colors.white),
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

//Schedule Widget
class ScheduleCard extends StatefulWidget {
  final String date;
  final String time;
  const ScheduleCard({Key? key, required this.date, required this.time}) : super(key: key);

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            widget.date,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 80,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),

          Flexible(
              child: Text(
                widget.time,
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}

void _scanQRCode() async {
  try {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.QR,
    );

    if (qrCode != '-1') {

      // Extract data from QR code
      List<String> qrDataParts = qrCode.split('\n');
      String appointmentDate = qrDataParts[1].split(': ')[1];
      String appointmentTime = qrDataParts[2].split(': ')[1];
      String firstName = qrDataParts[3].split(': ')[1];
      String lastName = qrDataParts[4].split(': ')[1];
      String email = qrDataParts[5].split(': ')[1];
      String phone = qrDataParts[6].split(': ')[1];

      // Do something with extracted data
      print('Appointment date: $appointmentDate      ');
      print('Appointment time: $appointmentTime      ');
      print('First name: $firstName                  ');
      print('Last name: $lastName                    ');
      print('Email: $email                           ');
      print('Phone: $phone                           ');
    }
  } on PlatformException {
    print("error occured !!!!!!!!!!!!!!!!!!!");
  }
}

