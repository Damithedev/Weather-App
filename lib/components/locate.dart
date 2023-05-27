import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Locate {
  Future<Position?> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return currentPosition;
    } catch (e) {
      // Handle location retrieval error
      print('Error retrieving location: $e');
    }

    return null;
  }

  Future<String> getLocationName(Position position) async {
    if (position != null) {
      double latitude = position.latitude;
      double longitude = position.longitude;

      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);
        if (placemarks != null && placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          return "${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
        } else {
          return "Unknown Location";
        }
      } catch (e) {
        print('Error: $e');
        return "Unknown Location";
      }
    }
    return "Error in getting location try again";
  }
}
