import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      print(permission);

      if (permission == LocationPermission.denied) {
        LocationPermission requestPermission =
            await Geolocator.requestPermission();

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);

        latitude = position.latitude;
        longitude = position.longitude;
      } else if (permission == LocationPermission.deniedForever) {
        print('Update the permission in the App Settings');
      } else if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);

        latitude = position.latitude;
        longitude = position.longitude;
      }
    } catch (e) {
      print(e);
    }
  }
}
