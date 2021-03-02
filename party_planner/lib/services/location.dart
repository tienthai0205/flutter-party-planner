import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  Future<String> getAddressFromLatLng(Position location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);

      Placemark place = placemarks[0];

      return "${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }
}
