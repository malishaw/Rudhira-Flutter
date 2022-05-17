import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class BloodBanksScreen extends StatefulWidget {
  @override
  _BloodBanksScreenState createState() => _BloodBanksScreenState();
}

class _BloodBanksScreenState extends State<BloodBanksScreen> {
  late GoogleMapController mapController;

  final CollectionReference _locations =
      FirebaseFirestore.instance.collection('locations_map');

  @override
  void initState() {
    getIcons();
    // _read();
    super.initState();
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      final QuerySnapshot result = await _locations.get();
      final List<DocumentSnapshot> documents = result.docs;
      print(documents[0]['lat'].data());
      var lat = documents[0]['lat'].data();
      var lan = documents[0]['lat'].data();
    } catch (e) {
      print(e);
    }
  }

  LatLng _center = LatLng(7.8, 80.6);
  late BitmapDescriptor icon;
// Cargar imagen del Marker
  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2),
        "assets/images/markeruser.png");
    setState(() {
      this.icon = icon;
    });
  }

  List<Marker> list = [
    Marker(
      markerId: MarkerId('Marker1'),
      position: LatLng(7.014983667960113, 79.99167595189628),
      infoWindow: InfoWindow(title: 'Business 1'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker2'),
      position: LatLng(7.717090253185, 79.96796253024269),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker3'),
      position: LatLng(7.090645611353458, 79.9618258324517),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker4'),
      position: LatLng(6.879051550613637, 79.87919043639128),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker5'),
      position: LatLng(7.0598218678460345, 79.90898305343492),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker6'),
      position: LatLng(6.404946020906727, 81.49346965075937),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker7'),
      position: LatLng(8.251736897997455, 79.99110644641623),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker8'),
      position: LatLng(9.245132312246653, 80.4143073490481),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker9'),
      position: LatLng(7.161369868287999, 80.96446852246953),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker10'),
      position: LatLng(6.057868679284584, 80.52010757470606),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker11'),
      position: LatLng(7.850109109138285, 81.17050112364375),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker12'),
      position: LatLng(7.850109109138285, 81.17050112364375),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker13'),
      position: LatLng(7.885022892925693, 80.77318768516108),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker14'),
      position: LatLng(8.278389645586863, 80.4655901844003),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId('Marker15'),
      position: LatLng(7.386435053511636, 80.74114627883183),
      infoWindow: InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Banks"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 7.7,
        ),
        markers: list.toSet(),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      setState(() {
        //   markers.addAll(list);
      });
    });
  }
}
