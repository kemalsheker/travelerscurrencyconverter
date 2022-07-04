import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ExchangeRates {


  Map<String, String> currencyItems = {};


  Future<void> convertFromTo(String from, String to) async {
    String url_str = "https://api.exchangerate.host/convert?from=$from&to=$to&amount=100";
    http.Response response = await http.get(Uri.parse(url_str));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
    } else {
      print(response.statusCode);
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