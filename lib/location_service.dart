import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';


class Location {

  String _locationName = '';
  static const String googleUrl = 'https://www.google.com/maps/search/?api=1&map_action=map&query=exchange+office&zoom=20';
  static const String mapsAppUrl = 'geo:0.0';

  Future<String> getLocationName() async{
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark  = placemarks[0];
      _locationName = placeMark.subAdministrativeArea! + ", " + placeMark.isoCountryCode!;
      return _locationName;
    }catch(e){
      print(e);
      return 'Error';
    }
  }

  Future<void> openMap() async {

    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }




}