import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controller/TextController.dart';
import '../../Utils/colors.dart';
import '../../widgets/small_text.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
   TextController textController = Get.find<TextController>();
  late final LatLng _initialLocation = LatLng(
    double.parse(textController.latitude.value),
    double.parse(textController.lontitude.value),
  );
  LatLng? _chosenLocation;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onLocationSelected(LatLng location) {
    setState(() {
      _chosenLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: SmallText(
          text: 'Choose clinic Location',
          color: Colors.white,
          size: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _initialLocation, zoom: 15),
        onMapCreated: _onMapCreated,
        onTap: _onLocationSelected,
        // ignore: prefer_collection_literals
        markers: Set<Marker>.of([
          // Marker(
          //   markerId: const MarkerId('initial_location'),
          //   position: _initialLocation,
          //   infoWindow: const InfoWindow(
          //     title: 'Initial Location',
          //   ),
          // ),
          if (_chosenLocation != null)
            Marker(
              markerId: const MarkerId('Hospital Location'),
              position: _chosenLocation!,
              infoWindow: const InfoWindow(
                title: 'Hospital Location',
              ),
            ),
          if (_chosenLocation == null)
            Marker(
              markerId: const MarkerId('Hospital Location'),
              position: _initialLocation,
              infoWindow: const InfoWindow(
                title: 'Hospital Location',
              ),
            ),
        ]),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 50),
        child: FloatingActionButton(
          backgroundColor: AppColors.mainColor,
          onPressed: () {
            textController.latitude.value =
                (_chosenLocation?.latitude).toString();
            textController.lontitude.value =
                (_chosenLocation?.longitude).toString();
            Get.back();
          },
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController _controller;
//   late Position _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   void _getCurrentLocation() async {
//     final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _currentPosition = position;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentPosition != null
//           ? GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   _currentPosition.latitude,
//                   _currentPosition.longitude,
//                 ),
//                 zoom: 14.0,
//               ),
//               onMapCreated: (controller) {
//                 _controller = controller;
//               },
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
