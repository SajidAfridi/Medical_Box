import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'history_screen.dart';

List<Coordinate> coordinates = [];

class MapScreen extends StatefulWidget {
  final String userID;

  const MapScreen({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double lat1 = 0.0;
  double lat2 = 0.0;
  double long1 = 0.0;
  double long2 = 0.0;
  String tripId = '';
  String? adminID;
  String? boxID;
  String? sessionDate;
  GoogleMapController? mapController;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  String currentTemperature = '0.0';
  String highTemperature = '0.0';
  String startTime = "10:10:10";
  String endTime = "10:10:10";
  bool isThresholdTemperature = false;
  String lowTemperature = '0.0';

  getTrip() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    _databaseReference
        .child('/$adminID/${widget.userID}/$boxID/$formattedDate/')
        .limitToLast(1)
        .onValue
        .listen((event) {
      tripId = (event.snapshot.children.last.key)!;
    });
    setState(() {
      sessionDate = formattedDate.toString();
    });
  }

  getUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('All_Users')
            .doc(widget.userID)
            .get();

    if (snapshot.exists) {
      final userData = snapshot.data();
      String? boxId = userData?['BoxId'];
      String? adminId = userData?['AdminId'];
      setState(() {
        boxID = boxId;
        adminID = adminId;
      });
    }
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    _databaseReference
        .child('/$adminID/${widget.userID}/$boxID/$formattedDate/')
        .limitToLast(1)
        .onValue
        .listen((event) {
      tripId = (event.snapshot.children.last.key)!;
    });
    print('$adminID ${widget.userID}, $boxID ,$formattedDate , $tripId');

    DatabaseEvent snapshotNo2 = await _databaseReference
        .child('/$adminID/${widget.userID}/$boxID/$formattedDate/$tripId/')
        .once();

    if (snapshotNo2.snapshot.value != null) {
      snapshotNo2.snapshot.children.forEach((element) {
        lowTemperature = element
                .child('Info')
                .child('LowTemperature')
                .value
                ?.toString() as String? ??
            '0.0';
        highTemperature = element
                .child('Info')
                .child('HighTemperature')
                .value
                ?.toString() as String? ??
            '0.0';
        currentTemperature = element
                .child('Info')
                .child('CurrentTemperature')
                .value
                ?.toString() as String? ??
            '0.0';
        // isThresholdTemperature =element.child('Info').child('CurrentTemperature').value?.toString() as bool? ?? true ;
      });

      snapshotNo2.snapshot.children.forEach((element) {
        startTime = element.child('Timing').child('Start').value?.toString()
                as String? ??
            '0-0-0';
        endTime =
            element.child('Timing').child('End').value?.toString() as String? ??
                '0-0-0';
      });
    }

    setState(() {
      sessionDate = formattedDate.toString();
    });

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    coordinates.clear();
  }

  void _updateCoordinates(Map<dynamic, dynamic> data) {
    coordinates.clear();
    data.forEach((key, value) {
      dynamic latitude = value['latitude'] == 0 ? 0.0 : value['latitude'];
      dynamic longitude = value['Longitude'] == 0 ? 0.0 : value['Longitude'];
      Coordinate coordinate =
          Coordinate(latitude: latitude, longitude: longitude);
      coordinates.add(coordinate);
    });

    if (coordinates.isNotEmpty) {
      lat1 = coordinates.first.latitude;
      lat2 = coordinates.last.latitude;
      long1 = coordinates.first.longitude;
      long2 = coordinates.last.longitude;
      _updateMap(lat1, long1);
    }
  }

  void _updateMap(double latitude, double longitude) {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15.0,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location'),
        backgroundColor: Colors.blue.withOpacity(0.7),
        actions: [
          IconButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HistoryScreen(
                    userID: widget.userID,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: currentTemperature == '0.0'
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'The user is currently Offline',
                    style: TextStyle(color: Colors.red, fontSize: 18.sp),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Container(
                    padding: EdgeInsets.all(16.0.r),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12.0.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5.r,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Start Time:',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'End Time:',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: Text(
                            '0 °C',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Low Temp:',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'High Temp:',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])
          : StreamBuilder(
              stream: _databaseReference
                  .child(
                    '/$adminID/${widget.userID}/$boxID/$sessionDate/$tripId/Location/',
                  )
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final event = snapshot.data as DatabaseEvent;
                  final Map<dynamic, dynamic> data = {};
                  for (var child in event.snapshot.children) {
                    data[child.key] = child.value;
                  }
                  _updateCoordinates(data);
                  return Stack(children: [
                    GoogleMap(
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(37.4219999, -122.0840575),
                        zoom: 30.0,
                      ),
                      markers: _getMarkers(),
                      polylines: _createPolylines(),
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                      child: Container(
                        padding: EdgeInsets.all(16.0.r),
                        decoration: BoxDecoration(
                          color: isThresholdTemperature
                              ? Colors.lightBlue.withOpacity(0.7)
                              : Colors.red.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.0.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Start Time: $startTime',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'End Time: $endTime',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Center(
                              child: Text(
                                '$currentTemperature°C',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Low Temp: $lowTemperature°C',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'High Temp: $highTemperature°C',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }

  Set<Polyline> _createPolylines() {
    List<LatLng> polylineCoordinates = [];
    for (var coordinate in coordinates) {
      polylineCoordinates
          .add(LatLng(coordinate.latitude, coordinate.longitude));
    }

    Polyline polyline = Polyline(
      polylineId: const PolylineId('polyline'),
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    return <Polyline>{polyline};
  }

  Set<Marker> _getMarkers() {
    final Marker marker1 = Marker(
      markerId: const MarkerId(''),
      position: LatLng(lat1, long1),
      infoWindow: const InfoWindow(title: 'Started '),
    );
    final Marker marker2 = Marker(
      markerId: const MarkerId('myLocation'),
      position: LatLng(lat2, long2),
      infoWindow: const InfoWindow(title: 'Ended'),
    );

    return {marker1, marker2};
  }
}

class Coordinate {
  final dynamic latitude;
  final dynamic longitude;

  Coordinate({required this.latitude, required this.longitude});
}
