import 'package:flutter/material.dart';
import 'constants.dart';
import 'exchange_service.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class exchangeWidget extends StatefulWidget {
  exchangeWidget({Key? key, this.defaultFromValue = '100.00'}) : super(key: key);

  final String defaultFromValue;

  @override
  _exchangeWidgetState createState() => _exchangeWidgetState();
}

class _exchangeWidgetState extends State<exchangeWidget> {
  ExchangeRates exchangeRates = ExchangeRates();
  Map<String, String> currencySymbols = {};

  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  late String fromValue;
  String toValue = '';
  late var currencyControllerFrom;
  late TextEditingController _controllerTo;


  @override
  void initState() {
    fromValue = widget.defaultFromValue;
    currencyControllerFrom =  MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: '',  initialValue: double.parse(fromValue));
    _controllerTo = TextEditingController(text: toValue);
    exchangeRates.getCurrencyList().then((mapCurrency) {
      setState(() {
        currencySymbols.addAll(mapCurrency);
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
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
                  fit: FlexFit.loose,
                  child: DropdownButton(
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
                    onChanged: (String? newValue) async{
                      fromCurrency = newValue!;
                      toValue =  await exchangeRates.convertFromTo(fromCurrency, toCurrency, fromValue);
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
                    onChanged: (String? value) async{
                        fromValue = value!;
                        toValue =  await exchangeRates.convertFromTo(fromCurrency, toCurrency, fromValue);
                        print(toValue);
                        setState(() {
                          _controllerTo = TextEditingController(text: toValue);
                        });
                    },
                  ),
                ),
                swapRow,
                kFromFlexible,
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: DropdownButton(
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
                    value: toCurrency,
                    onChanged: (String? newValue) async{
                      toCurrency = newValue!;
                      toValue =  await exchangeRates.convertFromTo(fromCurrency, toCurrency, fromValue);
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
