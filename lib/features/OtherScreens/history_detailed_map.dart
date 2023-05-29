import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

List<Coordinate> coordinates = [];

class HistoryMapScreen extends StatefulWidget {
  final String? adminID, UserID, BoxID, SessionID, TripID;

  const HistoryMapScreen(
      {Key? key,
        required this.adminID,
        required this.UserID,
        required this.BoxID,
        required this.SessionID,
        required this.TripID})
      : super(key: key);

  @override
  _HistoryMapScreenState createState() => _HistoryMapScreenState();
}

class _HistoryMapScreenState extends State<HistoryMapScreen> {
  double lat1 = 0.0;
  double lat2 = 0.0;
  double long1 = 0.0;
  double long2 = 0.0;
  String session = '';
  String trip = '';
  GoogleMapController? mapController;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  String currentTemperature = '0.0';
  String highTemperature = '0.0';
  String startTime = "10:10:10";
  String endTime = "10:10:10";
  bool isThresholdTemperature = false;
  String lowTemperature = '0.0';

  getData() async {
    DatabaseEvent snapshot = await _databaseReference
        .child(
        '/${widget.adminID}/${widget.UserID}/${widget.BoxID}/${widget.SessionID}/${widget.TripID}/')
        .once();

    if (snapshot.snapshot.value != null) {
      lowTemperature = snapshot.snapshot.children.first
          .child('LowTemperature')
          .value
          ?.toString() ??
          '0.0';
      highTemperature = snapshot.snapshot.children.first
          .child('HighTemperature')
          .value
          ?.toString() ??
          '0.0';
      currentTemperature = snapshot.snapshot.children.first
          .child('CurrentTemperature')
          .value
          ?.toString() ??
          '0.0';
      endTime = snapshot.snapshot.children.last.child('End').value?.toString() ??
          '0.0';
      startTime = snapshot.snapshot.children.last
          .child('Start')
          .value
          ?.toString() ??
          '0.00';
      isThresholdTemperature = snapshot.snapshot.children.first
          .child('IsUnderThreshold')
          .value
          ?.toString() as bool? ??
          true;
      /*   print( snapshot.snapshot.children.first.child('CurrentTemperature').value  );
      print( snapshot.snapshot.children.first.child('HighTemperature').value  );
      print( snapshot.snapshot.children.first.child('IsUnderThreshold').value  );
      print( snapshot.snapshot.children.last.child('Start').value  );
      print( snapshot.snapshot.children.last.child('End').value  );*/
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
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
        title: const Text('Location History'),
        backgroundColor: Colors.blue.withOpacity(0.7),
      ),
      body: StreamBuilder(
        stream: _databaseReference
            .child(
          '/${widget.adminID}/${widget.UserID}/${widget.BoxID}/${widget.SessionID}/${widget.TripID}/Location/',
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

            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(37.4219999, -122.0840575),
                    zoom: 15.0,
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
                      color: isThresholdTemperature ? Colors.lightBlue.withOpacity(0.7) : Colors.red.withOpacity(0.8),
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
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'End Time: $endTime',
                              style: TextStyle(
                                fontSize: 13.sp,
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
              ],
            );
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
      polylineCoordinates.add(LatLng(coordinate.latitude, coordinate.longitude));
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
      infoWindow: const InfoWindow(title: 'Started'),
    );
    final Marker marker2 = Marker(
      markerId: const MarkerId('myLocationyy'),
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
