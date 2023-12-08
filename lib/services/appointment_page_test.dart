import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import '../utils/config.dart';



class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}
String? name;
String? date;
String? time;
String? doctorName;
// Get the current date in the format used in Firestore (yyyy-MM-dd)
//String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//String dateString = currentDate.toString();




String formatDate(DateTime date) {
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  String year = date.year.toString();
  return '$day-$month-$year';
}

DateTime now = DateTime.now();
String formattedDate = formatDate(now);


final List<Client> clients = [];


class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {

// @override
// void initState() {
//   super.initState();
// }

  @override
  void initState() {
    super.initState();
    fetchClients();

  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();


  Future<void> getDoctorName() async {
    try {
      // Get the Firestore instance and reference to the document that contains the doctor's information.
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference documentReference = firestore.collection('doctors').doc(FirebaseAuth.instance.currentUser?.uid);

      // Fetch the document data.
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Extract the doctor name from the document data.
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          doctorName = data['name'];
        });
        print("current authenticated name is $doctorName ");
//        print('$dateString!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      }
    } catch (e) {
      // Handle errors.
      print('Failed to get doctor name: $e');
    }
  }





  final CollectionReference clientsCollection = FirebaseFirestore.instance.collection('todayAppointments');
  void addClient(Client client) async {
    QuerySnapshot querySnapshot = await clientsCollection
        .where('name', isEqualTo: client.name)
        .where('date', isEqualTo: client.date)
        .get();

    if (querySnapshot.docs.isEmpty) {
      clientsCollection.add({
        'name': client.name,
        'date': client.date,
        'time': client.time,
        'createdAt': DateTime.now(),
        'doctor' : doctorName,

      }).then((_) => fetchClients());
    } else {
      // Show a red snackbar if the client already exists
      const snackbar = SnackBar(
        content: Text('Client already exist.'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }


  Future<void> fetchClients() async {
    final QuerySnapshot querySnapshot = await clientsCollection
        .orderBy('createdAt', descending: false)
//        .where('date', isEqualTo: " $formattedDate")
        .get();
    clients.clear();
    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      clients.add(Client(
        name: data['name'],
        date: data['date'],
        time: data['time'],
      ));
      setState(() {});

    }

  }

















  final CollectionReference appointmentsCollection = FirebaseFirestore.instance.collection('appointment');

  Future<void> fetchAppointments( String name) async {
    try {
      print('$doctorName  ***** $name **********************************************************');
      final QuerySnapshot querySnapshot = await appointmentsCollection
          .where('doctor', isEqualTo: doctorName)
          .where('date', isEqualTo: formattedDate)
          .where('name', isEqualTo: name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          if (data['date'] == formattedDate) {
           // clients.add(Client(name: name, date: formattedDate, time: time!));
            addClient(Client(name: name, date: formattedDate, time: data['time']!));
            fetchClients();

            // Show a green snackbar if there are results
            const snackbar = SnackBar(
              content: Text('Appointment fetched successfully.'),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);


            break;
          } else {
            // Show a red snackbar if there are no results
            final snackbar = SnackBar(
              content: Text('No appointments found for $name.'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        }
      } else {
        // Show a red snackbar if there are no results
        final snackbar = SnackBar(
          content: Text('No appointments found for $name.'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      // Show a red snackbar if there was an error
      final snackbar = SnackBar(
        content: Text('Error fetching appointments: $e'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }






  Future<void> _refreshPage() async {
    setState(() {
      clients.clear();
    });
    await fetchClients();
  }

  final _nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh:()=>_refreshPage(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(0, 1, 1, 1),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.person_add_alt_outlined),
            onPressed: () {
              // Do something when the icon button is pressed

              showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Person'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter name',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Search'),
                      onPressed: () async {
                        String? name = _nameController.text;
                       if(name.isNotEmpty ) {
                            Navigator.of(context).pop();
                            print("$_nameController.text       !!!!!!!!!!!!!!!!!!!!!!!");
                            await getDoctorName().then((_) => fetchAppointments('$name'));
                            setState(() {});
                          }
                        },
                    ),
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
              );



            },
          ),
          foregroundColor: Colors.black,
          title: const Center(child: Text('Appointments',style: TextStyle(fontSize: 25),)),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.qr_code_scanner_outlined),
              onPressed: () async {
                //_scanQRCode();
               final result = await Navigator.of(context).pushNamed('qr_scanner_page');
               if (result != null) {
                 Map<String, dynamic> data = result as Map<String, dynamic>;
                  name = data['name'] as String;
                  date = data['date'] as String;
                  time = data['time'] as String;

                 print('$name   $date    $time   !!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                 await fetchAppointments( name!);
                 setState(() {});
                 // do something with the data
               }

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
      ),
    );
  }




}


class ClientListPage extends StatefulWidget {


  ClientListPage({Key? key}) : super(key: key);

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {


  void deleteClient(Client client) {
    setState(() {
      clients.remove(client);
    });
  }


  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients.elementAt(index);

        return ClientCard(client: client, onDelete:deleteClient,);
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
  final Function(Client) onDelete;

  const ClientCard({Key? key, required this.client, required this.onDelete}) : super(key: key);

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  late Client client;
  late Function(Client) onDelete;
  @override
  void initState() {
    super.initState();
    client = widget.client;
    onDelete = widget.onDelete;
  }


  final CollectionReference clientsCollection = FirebaseFirestore.instance.collection('todayAppointments');



  void deleteClient(Client client) async {
    print('$doctorName §§§§§§§§§§§§§§§§§§§§§§§§');
    await clientsCollection
        .where('name', isEqualTo: client.name)
        .where('date', isEqualTo: client.date)
        .where('doctor', isEqualTo: doctorName)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
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
               //const Padding(
               //  padding: EdgeInsets.all(8.0),
               //  child: CircleAvatar(
               //    radius: 30,
               //    backgroundImage: AssetImage("assets/images/x.png"),
               //  ),
               //),
                Config.spaceSmall,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Text(
                    widget.client.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
                      deleteClient(client);
                      const snackbar = SnackBar(
                        content: Text('Appointment Completed.'),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },


                   //{
                   //  setState(() {
                   //    clients.remove(client);
                   //    // Change the status of the client to "Cancel"
                   //    //client.status = 'Cancel';
                   //  });
                   //},

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