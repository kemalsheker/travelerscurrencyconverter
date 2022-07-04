import 'package:flutter/material.dart';
import 'constants.dart';
import 'location_service.dart';
import 'package:url_launcher/url_launcher.dart';


class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  final Location _location = Location();
  String nearOfficeLocation = '';

  @override
  void initState() {
    _location.getLocationName().then((locationName)  {
      setState(() {
        nearOfficeLocation = locationName;
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 200.0,
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape:  RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: kCardElevation,
        child: Column(children: <Widget>[
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.centerLeft,
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Nearest Exchange Offices',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16.0
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children:  <Widget>[
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.black,
                          size: 16.0,
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text( nearOfficeLocation ,
                          style: const TextStyle(color: Colors.grey, fontSize: 11.0),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.loose,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset('images/mapLocation.jpg', fit: BoxFit.fill,),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async{
                        await _location.openMap();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
