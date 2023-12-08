/*
import 'package:doctor_app_v3/components/client_information_page.dart';
import 'package:doctor_app_v3/utils/config.dart';
import 'package:flutter/material.dart';


class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate = DateTime.now();
  int selectedTime = 0;
  int selectedMin = 0;



  final List<bool> _timeSlotsTaken = List.generate(40, (index) => false);





  final List<Client> _clients = [
    Client(
      name: 'Alice',
      cin: 'CIN-111',
      phoneNumber: '123-456-7890',
      date: DateTime.now(),
      time: TimeOfDay(hour: 9, minute: 0),
    ),
    Client(
      name: 'Bob',
      cin: 'CIN-222',
      phoneNumber: '234-567-8901',
      date: DateTime.now(),
      time: TimeOfDay(hour: 10, minute: 0),
    ),
    Client(
      name: 'Darouish',
      cin: 'AE296516',
      phoneNumber: '234-567-8901',
      date: DateTime.now().add(Duration(days: 2)),
      time: TimeOfDay(hour: 10, minute: 0),
    ),
    Client(
      name: 'Charlie',
      cin: 'CIN-333',
      phoneNumber: '345-678-9012',
      date: DateTime.now(),
      time: TimeOfDay(hour: 11, minute: 0),
    ),
    Client(
      name: 'David',
      cin: 'CIN-444',
      phoneNumber: '456-789-0123',
      date: DateTime.now(),
      time: TimeOfDay(hour: 12, minute: 0),
    ),
    Client(
      name: 'Emma',
      cin: 'CIN-555',
      phoneNumber: '567-890-1234',
      date: DateTime.now(),
      time: TimeOfDay(hour: 13, minute: 0),
    ),
  ];



  List<Client> get _filteredClients {
    print(selectedDate);
    return _clients.where((client) => client.date.day == selectedDate!.day && client.date.month ==selectedDate!.month ).toList();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Dr. ZAKARIA",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/x.png'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 10),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                          : "Select Date",
                      style: TextStyle(
                        fontSize: 20,
                        color: selectedDate != null
                            ? Colors.blueGrey[900]
                            : Config.primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 30,
                      color: selectedDate != null
                          ? Colors.blueGrey[900]
                          : Config.primaryColor,
                    ),
                  ],
                ),
              ),
              onTap: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now().weekday == DateTime.sunday
                        ? DateTime.now().add(const Duration(days: 1)) // if today is Sunday, set initial date to Monday
                        : DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    selectableDayPredicate: (DateTime date) {
                      // Disable Sunday
                      return date.weekday != DateTime.sunday;
                    }).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedDate = value;
                      selectedTime = 0; // reset selected time
                    });
                  }

                });
              },
            ),
            const SizedBox(height: 10),
            const Text(
              "Select Time:",
              style: TextStyle(
                fontSize: 20,
                color: Config.primaryColor,
              ),
            ),
            const SizedBox(height: 20),



            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(

                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                  childAspectRatio: 3/2,
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: 40,
                itemBuilder: (context, index) {
                  final time = TimeOfDay(
                      hour: index ~/ 4 + 8,
                      minute: (index % 4 == 0) ? 00 : (index % 4) * 15);
                  bool isTaken = _filteredClients.any((client) => client.time.hour == time.hour && client.time.minute == time.minute);
                  print(_filteredClients.any((client) => client.time.hour == time.hour && client.time.minute == time.minute));
                  _timeSlotsTaken[index] = isTaken;
                  return Container(

                    decoration: BoxDecoration(
                      color: isTaken ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: AspectRatio(
                      aspectRatio: 3/2,
                      child: ElevatedButton(

                        onPressed:selectedDate == null? null : isTaken
                            ? () {
                          final client = _filteredClients.firstWhere((client) =>
                          client.time.hour == time.hour &&
                              client.time.minute == time.minute);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(client.name),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CIN: ${client.cin}'),
                                  const SizedBox(height: 8),
                                  Text('Phone: ${client.phoneNumber}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _timeSlotsTaken[index] = false;
                                      _clients.remove(client);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel appointment'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        }
                            : () {

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ClientInformation(selectedDate: selectedDate!, selectedTime: time.hour, selectedMin: time.minute),
                          ));


                          setState(() {
                            _timeSlotsTaken[index] = true;
                            _clients.add(Client(
                              name: 'Client ${_filteredClients.length + 1}',
                              cin: 'CIN-${_filteredClients.length + 1}',
                              phoneNumber: '123-456-7890',
                              date: selectedDate!,
                              time: time,
                            ));
                          });



                        },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: isTaken ? Colors.red : Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16)
                        ),

                        child: Container(
                          decoration: BoxDecoration(

                            color: isTaken ? Colors.red : Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                              style:  TextStyle(fontSize: 18, color: isTaken ? Colors.black : Colors.white,),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class Client {
  final String name;
  final String cin;
  final String phoneNumber;
  final DateTime date;
  final TimeOfDay time;

  Client({
    required this.name,
    required this.cin,
    required this.phoneNumber,
    required this.date,
    required this.time,
  });

  @override
  String toString() {
    return 'Client{name: $name, date: $date, time: $time}';
  }
}

 */
