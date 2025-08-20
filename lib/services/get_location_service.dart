// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class Location {
//   // get the user permition for current location
//   Future<String> getLocation() async {
//     // get the permition from the user to access the location
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     // get the current location
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     // convert the city name im to list of place marks
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position.altitude,
//       position.longitude,
//     );

//     print(position.latitude);
//     print(position.longitude);
//     // extract the city name fron the place marks
//     String cityName = placemarks[0].locality!;
//     print(cityName);
//     return cityName;
//   }
// }

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  // Get the user's current city name
  Future<String> getLocation() async {
    try {
      // Request permission from the user
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get placemarks from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      print(position.latitude);
      print(position.longitude);

      // Extract and return the city name
      String cityName = placemarks[0].locality ?? 'Unknown';
      print(cityName);
      return cityName;
    } catch (error) {
      print("Error $error");
    }
    return "";
  }
}
