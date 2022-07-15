import 'package:flutter/material.dart';
import 'constants.dart';
import 'exchangeMap.dart';
import 'exchangeWidget.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ExchangeApp());
}



class ExchangeApp extends StatelessWidget {
  const ExchangeApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Traveler's Currency Converter",
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment : CrossAxisAlignment.stretch,
                children:   <Widget>[
                  Flexible(flex: 3, fit: FlexFit.tight,child: exchangeWidget()),
                  const Flexible(flex: 2, fit: FlexFit.tight,child: MapWidget()),
                ],
              ),
            ),
        ),
      ),
    );
  }
}

