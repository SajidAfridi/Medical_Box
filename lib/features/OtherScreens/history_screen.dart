import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/features/OtherScreens/history_detailed_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key, required this.userID}) : super(key: key);
  final String userID;

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> sessions = [];
  List<String> trips = [];
  String? selectedSession;
  String? adminID;
  String? boxID;

  @override
  void initState() {
    super.initState();
    getAdminID();
    fetchDataOnce();
  }

  fetchDataOnce() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance
        .collection('All_Users')
        .doc(widget.userID)
        .get();

    if (snapshot.exists) {
      final userData = snapshot.data();
      var adminID = userData?['adminID'];
      final boxId = userData?['BoxId'];
      setState(() {
        adminID = adminID;
        boxID = boxId;
      });
      if (adminID != null && boxId != null) {
        return {'username': adminID, 'boxID': boxId};
      }
    }
    DatabaseReference sessionReference = FirebaseDatabase.instance
        .ref()
        .child(adminID!)
        .child(widget.userID)
        .child(boxID!);

    DatabaseEvent sessionEvent = await sessionReference.once();
    for (var session in sessionEvent.snapshot.children) {
      sessions.add(session.key.toString());
    }

    setState(() {});

    if (sessions.isNotEmpty) {
      selectedSession = sessions[0];
      await fetchTrips(selectedSession!);
    }
  }

  Future<void> refreshData() async {
    sessions.clear();
    trips.clear();
    await fetchDataOnce();
  }

  void onSessionChanged(String? selectedSession) async {
    setState(() {
      this.selectedSession = selectedSession;
    });

    if (selectedSession != null) {
      await fetchTrips(selectedSession);
    }
  }

  Future<void> fetchTrips(String selectedSession) async {
    trips.clear();

    DatabaseReference tripReference = FirebaseDatabase.instance
        .ref()
        .child(adminID!)
        .child(widget.userID)
        .child(boxID!)
        .child(selectedSession);

    DatabaseEvent tripEvent = await tripReference.once();
    for (var trip in tripEvent.snapshot.children) {
      trips.add(trip.key.toString());
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.blue.withOpacity(0.7),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: DropdownButton<String>(
                    value: selectedSession,
                    items: sessions.map((String session) {
                      return DropdownMenuItem<String>(
                        value: session,
                        child: Center(
                          child: Text(
                            'Session: $session',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: onSessionChanged,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0.r),
                    ),
                    child: ListTile(
                      title: Text(
                        'Trip: ${trips[index]}',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      tileColor: Colors.blue.withOpacity(0.7), // Change tile background color
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryMapScreen(
                              adminID: adminID,
                              UserID: widget.userID,
                              BoxID: boxID,
                              SessionID: selectedSession,
                              TripID: trips[index],
                            ),
                          ),
                        );
                      },
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

  Future<String?> getAdminID() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final adminId = sp.getString('adminID');
    setState(() {
      adminID = adminId;
    });
    return null;
  }
}
