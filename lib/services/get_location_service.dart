import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationService {
  // get the user permition for current location
  Future<String> getCityNameFromCurrentlocation() async {
    // get the permition from the user to access the location
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // get the current location
    Position position = await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );

    print(position.latitude);
    print(position.longitude);

    // convert the city name im to list of place marks
    List<Placemark> placemark = await placemarkFromCoordinates(
      position.altitude,
      position.longitude,
    );

    // extract the city name fron the place marks
    String cityName = placemark[0].locality!;
    print(cityName.toString());
    return cityName;
  }
}
