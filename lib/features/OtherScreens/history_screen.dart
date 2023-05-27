import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_database/firebase_database.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: FutureBuilder<DataSnapshot>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.value == null) {
            return Center(child: Text('No data available',style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: Colors.black,
            ),));
          }
          // Process the snapshot data
          final data = snapshot.data!.value;
          final sessions = (data as Map).keys.toList();
          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final sessionKey = sessions[index];
              final sessionData = data[sessionKey];
              final trips = (sessionData as Map).values.toList();
              return _buildSessionItem(sessionKey, trips as Map);
            },
          );
        },
      ),
    );
  }

  Future<DataSnapshot> fetchData() async {
    final databaseEvent = await databaseReference.child('2700084').once();
    return databaseEvent.snapshot;
  }

  Widget _buildSessionItem(String sessionName, Map<dynamic, dynamic> sessionData) {
    final sessions = sessionData.keys.toList();
    return Card(
      margin: EdgeInsets.all(16.w),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        children: sessions.map<ExpansionPanel>((session) {
          final sessionKey = session.toString();
          final sessionTrips = (sessionData[sessionKey] as Map<dynamic, dynamic>).keys.toList();
          return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(
                  sessionKey,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              );
            },
            body: Column(
              children: sessionTrips.map<Widget>((trip) {
                final tripData = (sessionData[sessionKey] as Map<dynamic, dynamic>)[trip];
                final timingStart = tripData['Timing']['Start'];
                final timingEnd = tripData['Timing']['End'];
                return ListTile(
                  title: Text('$trip (Start: $timingStart, End: $timingEnd)'),
                  subtitle: Text('Location: ${tripData['Location']}'),
                );
              }).toList(),
            ),
            // isExpanded: isExpanded,
          );
        }).toList(),
      ),
    );
  }
}
