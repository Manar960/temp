import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  Location? _location;
  LocationData? _currentLocation;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    _location = Location();
    _cameraPosition = CameraPosition(
        target: LatLng(0.0, 0.0), // Default lat and lng for initialization
        zoom: 15);
    await _initLocation();
  }

  // Function to initialize location services
  Future<void> _initLocation() async {
    bool serviceEnabled = await _location?.serviceEnabled() ?? false;
    if (!serviceEnabled) {
      serviceEnabled = await _location?.requestService() ?? false;
      if (!serviceEnabled) {
        // Handle case where location service is still not enabled
        return;
      }
    }

    _currentLocation = await _location?.getLocation();
    if (_currentLocation != null) {
      moveToPosition(LatLng(_currentLocation!.latitude ?? 0.0,
          _currentLocation!.longitude ?? 0.0));
    }

    _location?.onLocationChanged.listen((newLocation) {
      if (newLocation != null) {
        _currentLocation = newLocation;
        moveToPosition(LatLng(_currentLocation!.latitude ?? 0.0,
            _currentLocation!.longitude ?? 0.0));
      }
    });
  }

  // Function to move the camera to a specific position
  Future<void> moveToPosition(LatLng latLng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: latLng, zoom: 15),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _getMap(),
        Positioned.fill(
          child: Align(alignment: Alignment.center, child: _getMarker()),
        ),
      ],
    );
  }

  Widget _getMarker() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.05,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            spreadRadius: 4,
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipOval(child: Image.asset("assets/addadm.png")),
    );
  }

  Widget _getMap() {
    return GoogleMap(
      initialCameraPosition: _cameraPosition!,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        if (!_googleMapController.isCompleted) {
          _googleMapController.complete(controller);
        }
      },
    );
  }
}
