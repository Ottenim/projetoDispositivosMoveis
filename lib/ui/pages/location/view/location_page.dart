import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => LocationPage());

  final LatLng _establishmentLocation = const LatLng(-29.444538586130435, -51.954900597813065); // Exemplo: São Paulo, Brasil
  final Completer<GoogleMapController> _controller = Completer();

  LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localização'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: _establishmentLocation,
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('barbearia'),
            position: _establishmentLocation,
            infoWindow: const InfoWindow(
              title: 'Barbearia',
              snippet: 'Aqui é a barbearia do Janei.',
            ),
          ),
        },
      ),
    );
  }
}
