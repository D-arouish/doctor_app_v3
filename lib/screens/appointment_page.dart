import 'package:flutter/material.dart';


import '../utils/config.dart';



class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  var profileImage;
  NetworkImage? networkImage;



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(0, 1, 1, 1),
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Center(child: Text('Client Page')),
        bottom: TabBar(

          indicatorColor: Config.primaryColor,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Complete'),
            Tab(text: 'Cancel'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 10, right: 8),
          child: TabBarView(

            controller: _tabController,
            children:[
              ClientListPage(status: 'Upcoming'),
              ClientListPage(status: 'Complete'),
              ClientListPage(status: 'Cancel'),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientListPage extends StatefulWidget {
  final String status;

  ClientListPage({Key? key, required this.status}) : super(key: key);

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  @override
  Widget build(BuildContext context) {
    final clients = [
      Client(name: 'John Doe', status: 'Upcoming'),
      Client(name: 'Jane Doe', status: 'Complete'),
      Client(name: 'Bob Smith', status: 'Cancel'),
    ].where((client) => client.status == widget.status);

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
  String status;

  Client({required this.name, required this.status});
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
            const ScheduleCard(),
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
                        // Change the status of the client to "Cancel"
                        client.status = 'Cancel';
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
class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Monday, 4/3/2023',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
                '02:00PM',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
