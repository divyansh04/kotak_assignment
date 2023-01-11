import 'dart:convert';

import 'package:flutter_application_1/home/model/currency_list_model.dart';
import 'package:flutter_application_1/home/model/exchange_rate_model.dart';
import 'package:http/http.dart' as http;

abstract class CurrencyRepo {
  Future<CurrencyListModel> fetchCurrencyList(http.Client client);
  Future<ExchangeRateModel> fetchConversionResult(
      String base, String symbol, http.Client client);
}

class CurrencyRepoImpl extends CurrencyRepo {
  static const String apiKey = 'VjkJgb9Azs2hy7TK2LUOVwIZhPwqNNnO';

  @override
  Future<CurrencyListModel> fetchCurrencyList(http.Client client) async {
    var url = Uri.parse('https://api.apilayer.com/exchangerates_data/symbols');
    var response = await client.get(url, headers: {"apikey": apiKey});

    if (response.statusCode == 200) {
      final json = Map<String, dynamic>.from(jsonDecode(response.body));
      return CurrencyListModel.fromJson(json);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<ExchangeRateModel> fetchConversionResult(
      String base, String symbol, http.Client client) async {
    var url = Uri.parse(
        'https://api.apilayer.com/exchangerates_data/latest?symbols=$symbol&base=$base');
    var response = await client.get(url, headers: {"apikey": apiKey});

    if (response.statusCode == 200) {
      final json = Map<String, dynamic>.from(jsonDecode(response.body));
      return ExchangeRateModel.fromJson(json);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
