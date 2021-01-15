import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadow/config/config.dart';
import 'package:shadow/view/view.dart';

class MapViewScreen extends StatefulWidget {
  @override
  _MapViewScreenState createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  GoogleMapController _googleMapController;
  static final LatLng _center = const LatLng(18.5248902, 73.7225354);
  final Set<Marker> _markers = {};
  LatLng _currentMapPosition = _center;

  _onMapCreated(GoogleMapController mapController) {
    _googleMapController = mapController;
  }

  _onCameraMove(CameraPosition cameraPosition) {
    _currentMapPosition = cameraPosition.target;
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(_currentMapPosition.toString()),
            position: _currentMapPosition,
            infoWindow: InfoWindow(
                title: 'Pune',
                onTap: () {
                  print('On InfoWindow Click');
                },
                snippet: 'Welcome to Pune'),
            icon: BitmapDescriptor.defaultMarker),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBarTitle(title: AppConstant.Map),
            SizedBox(height: 20,),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 10.0,
                    ),
                    markers: _markers,
                    onCameraMove: _onCameraMove,

                    // these will help to detect gesture for map only start
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    // these will help to detect gesture for map only end
                  ),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(
                        onPressed: _onAddMarkerButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.green,
                        child: const Icon(
                          Icons.map,
                          size: 25.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
