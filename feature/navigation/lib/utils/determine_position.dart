import 'package:geolocator/geolocator.dart';

Future<({double latitude, double longitude})> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission != LocationPermission.whileInUse &&
      permission != LocationPermission.always) {
    return Future.error('Location permissions are denied');
  }

  final position = await Geolocator.getCurrentPosition();
  return (latitude: position.latitude, longitude: position.longitude);
}
