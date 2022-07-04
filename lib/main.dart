import 'package:flutter/material.dart';
import 'exchangeMap.dart';
import 'exchangeWidget.dart';

void main() {
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
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment : CrossAxisAlignment.stretch,
                children:  <Widget>[
                  const Flexible(flex: 3, fit: FlexFit.tight,child: exchangeWidget()),
                  Flexible(flex: 2, fit: FlexFit.tight,child: Container()),
                  const Flexible(flex: 2, fit: FlexFit.tight,child: MapWidget()),
                ],
              ),
            ),
        ),
      ),
    );
  }
}

