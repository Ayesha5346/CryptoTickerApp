import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const Apikey = '0CF072A1-AB00-41DD-AB63-DFEF86AA7147';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String btcRate, ethRate, ltcRate;

  Future GetCurrentRate(val) async {
    String uri =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$val?apikey=$Apikey';
    http.Response temp = await http.get(Uri.parse(uri));
    String data = temp.body;
    var decodedData = jsonDecode(data);
    return decodedData;
  }

  Future GetETHCurrentRate(val) async {
    String uri =
        'https://rest.coinapi.io/v1/exchangerate/ETH/$val?apikey=$Apikey';
    http.Response temp = await http.get(Uri.parse(uri));
    String data = temp.body;
    var decodedData = jsonDecode(data);
    return decodedData;
  }

  Future GetLTCCurrentRate(val) async {
    String uri =
        'https://rest.coinapi.io/v1/exchangerate/LTC/$val?apikey=$Apikey';
    http.Response temp = await http.get(Uri.parse(uri));
    String data = temp.body;
    var decodedData = jsonDecode(data);
    return decodedData;
  }
}
