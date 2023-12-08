import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> _notifications = [
    {'name': 'John', 'dateTime': '2022-05-01 14:30'},
    {'name': 'Jane', 'dateTime': '2022-05-05 10:00'},{'name': 'John', 'dateTime': '2022-05-01 14:30'},
    {'name': 'Jane', 'dateTime': '2022-05-05 10:00'},
    {'name': 'John', 'dateTime': '2022-05-01 14:30'},
    {'name': 'Jane', 'dateTime': '2022-05-05 10:00'},
    {'name': 'John', 'dateTime': '2022-05-01 14:30'},
    {'name': 'Jane', 'dateTime': '2022-05-05 10:00'},
    {'name': 'John', 'dateTime': '2022-05-01 14:30'},
    {'name': 'Jane', 'dateTime': '2022-05-05 10:00'},
    {'name': 'John', 'dateTime': '2022-05-01 14:30'},
    {'name': 'Jane', 'dateTime': '2022-05-05 10:00'},
    {'name': 'John', 'dateTime': '2022-05-01 14:30'},
    {'name': 'Jane', 'dateTime': '2022-05-05 10:00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(0, 1, 1, 1),
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Center(child: Text('Notifications')),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return NotificationCard(
            name: _notifications[index]['name']!,
            dateTime: _notifications[index]['dateTime']!,
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String name;
  final String dateTime;

  const NotificationCard({Key? key, required this.name, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '$name canceled an appointment',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8.0),
                Text(dateTime),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
