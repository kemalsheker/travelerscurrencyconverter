import 'package:flutter/material.dart';
import 'constants.dart';
import 'exchange_service.dart';

class exchangeWidget extends StatefulWidget {
  const exchangeWidget({Key? key}) : super(key: key);

  @override
  _exchangeWidgetState createState() => _exchangeWidgetState();
}

class _exchangeWidgetState extends State<exchangeWidget> {
  ExchangeRates exchangeRates = ExchangeRates();
  Map<String, String> currencySymbols = {};

  String fromCurrency = 'USD';
  String toCurrency = 'EUR';


  @override
  void initState() {
    exchangeRates.convertFromTo(fromCurrency, toCurrency);
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
                onChanged: (String? newValue) {
                  setState(() {
                    fromCurrency = newValue!;
                    print(fromCurrency);
                  });
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
