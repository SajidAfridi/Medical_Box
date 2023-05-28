import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import 'history_screen.dart';

List<Coordinate> coordinates = [];

class MapScreen extends StatefulWidget {
  final String userID;
  const MapScreen({
    Key? key,required this.userID,
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

  getTrip(){
    DateTime now = DateTime.now();
    print(sessionDate);
    print(boxID);
    print(adminID);
    print(widget.userID);
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    _databaseReference.child('/$adminID/${widget.userID}/$boxID/$formattedDate/').limitToLast(1).onValue.listen((event) {
      print(event.snapshot.children.last.key);
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
    _databaseReference.child('/$adminID/${widget.userID}/$boxID/$formattedDate/').limitToLast(1).onValue.listen((event) {
      print(event.snapshot.children.last.key);
      tripId = (event.snapshot.children.last.key)!;
    });
    setState(() {
      sessionDate = formattedDate.toString();
      print(sessionDate);
      print(boxID);
      print(adminID);
      print(widget.userID);
      print(tripId);
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
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return HistoryScreen(userID: widget.userID);
            }));
          }, icon: const Icon(Icons.history)),
        ],
      ),

      body: StreamBuilder(
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
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.4219999, -122.0840575),
                  zoom: 15.0,
                ),
                markers: _getMarkers(),
                polylines: _createPolylines(),
              ),
            ]);
          } else {
            return Center(
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
      polylineId: PolylineId('polyline'),
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    return Set<Polyline>.from([polyline]);
  }

  Set<Marker> _getMarkers() {
    final Marker marker1 = Marker(
      markerId: MarkerId(''),
      position: LatLng(lat1, long1),
      infoWindow: InfoWindow(title: 'Started '),
    );
    final Marker marker2 = Marker(
      markerId: MarkerId('myLocationyy'),
      position: LatLng(lat2, long2),
      infoWindow: InfoWindow(title: 'Ended'),
    );

    return {marker1, marker2};
  }
}

class Coordinate {
  final dynamic latitude;
  final dynamic longitude;

  Coordinate({required this.latitude, required this.longitude});
}
