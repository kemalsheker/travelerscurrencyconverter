import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ExchangeRates {


  Map<String, String> currencyItems = {};
  double fromValue = 0.00;
  double toValue = 0.00;


  Future<String> convertFromTo(String from, String to, String amount) async {
    String url_str = "https://api.exchangerate.host/convert?from=$from&to=$to&amount=$amount";
    http.Response response = await http.get(Uri.parse(url_str));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body)['result'];
      if(data == null){
        return '0.00';
      }else {
        return data.toString().substring(0, data.toString().indexOf('.')+3);
      }
    } else {
      print(response.statusCode);
      return '0.00';
    }

  }


  Future<Map<String,String>> getCurrencyList() async {
    String url_str = "https://api.exchangerate.host/symbols";
    http.Response response = await http.get(Uri.parse(url_str));

    if(response.statusCode == 200){
      //var data = jsonDecode(response['symbols']);
      var data = jsonDecode(response.body)['symbols'];
      data.forEach((key, value){
        currencyItems[key.toString()] = value['description'].toString();
      });
      return currencyItems;
    } else {
      print(response.statusCode);
      return currencyItems;
    }
  }



}