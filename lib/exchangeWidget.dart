import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'exchange_service.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class exchangeWidget extends StatefulWidget {
  exchangeWidget({Key? key}) : super(key: key);

  @override
  _exchangeWidgetState createState() => _exchangeWidgetState();
}

class _exchangeWidgetState extends State<exchangeWidget> {
  ExchangeRates exchangeRates = ExchangeRates();
  Map<String, String> currencySymbols = {};

  String fromCurrency = '';
  String toCurrency = '';
  String fromValue = '';
  String toValue = '0.00';
  late var currencyControllerFrom;
  late TextEditingController _controllerTo;

  Future<void> readySharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    fromCurrency = sharedPreferences.getString("fromCurrency") ?? 'USD';
    toCurrency = sharedPreferences.getString("toCurrency") ?? 'EUR';
    setState(() {});
  }

  Future<void> saveDataFrom(String value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    fromCurrency = value;
    sharedPreferences.setString("fromCurrency", fromCurrency);
  }

  Future<void> saveDataTo(String value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    toCurrency = value;
    sharedPreferences.setString("toCurrency", toCurrency);
  }

  
  @override
  void initState() {
    currencyControllerFrom =
        MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: '');
    _controllerTo = TextEditingController(text: toValue);
    exchangeRates.getCurrencyList().then((mapCurrency) {
      setState(() {
        currencySymbols.addAll(mapCurrency);
      });
    });
    super.initState();
    readySharedPreferences();
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: kCardElevation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                kFromFlexible,
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: DropdownButton(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(12.0),
                    elevation: kDropDownElevation,
                    iconSize: 24.0,
                    items: currencySymbols
                        .map((description, value) {
                          return MapEntry(
                              description,
                              DropdownMenuItem(
                                value: description,
                                child: Text(description + ' , ' + value),
                              ));
                        })
                        .values
                        .toList(),
                    value: fromCurrency,
                    onChanged: (String? newValue) async {
                      fromCurrency = newValue!;
                      saveDataFrom(newValue);
                      toValue = await exchangeRates.convertFromTo(
                          fromCurrency, toCurrency, fromValue);
                      print(fromCurrency);
                      setState(() {
                        _controllerTo = TextEditingController(text: toValue);
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: currencyControllerFrom,
                    onChanged: (String? value) async {
                      fromValue = value!;
                      toValue = await exchangeRates.convertFromTo(
                          fromCurrency, toCurrency, fromValue);
                      print(toValue);
                      setState(() {
                        _controllerTo = TextEditingController(text: toValue);
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(child: kColumnDivider),
                    ElevatedButton(
                      child: const Icon(Icons.swap_vert),
                      onPressed: () async{
                        String temp = fromCurrency;
                        fromCurrency = toCurrency;
                        toCurrency = temp;
                        toValue = await exchangeRates.convertFromTo(
                            fromCurrency, toCurrency, fromValue);
                        setState(() {
                          _controllerTo = TextEditingController(text: toValue);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(18, 18),
                        shape: const CircleBorder(),
                      ),
                    ),
                    const Expanded(
                      child: kColumnDivider,
                    ),
                  ],
                ),
                kToFlexible,
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(12.0),
                    elevation: kDropDownElevation,
                    isExpanded: true,
                    iconSize: 24.0,
                    items: currencySymbols
                        .map((description, value) {
                          return MapEntry(
                              description,
                              DropdownMenuItem(
                                value: description,
                                child: Text(description + ' , ' + value),
                              ));
                        })
                        .values
                        .toList(),
                    value: toCurrency,
                    onChanged: (String? newValue) async {
                      toCurrency = newValue!;
                      saveDataTo(newValue);
                      toValue = await exchangeRates.convertFromTo(
                          fromCurrency, toCurrency, fromValue);
                      print(toCurrency);
                      setState(() {
                        _controllerTo = TextEditingController(text: toValue);
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: TextField(
                    enabled: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: _controllerTo,
                  ),
                ),
                kDataProvided,
              ]),
        ),
      ),
    );
  }
}
