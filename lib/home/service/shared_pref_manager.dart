import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  final SharedPreferences sharedPreferences;

  SharedPrefManager(this.sharedPreferences);

  Future<void> setCurrencyList(Map<String, String>? currencyList) {
    String res = '';
    if (currencyList != null) res = jsonEncode(currencyList);
    return sharedPreferences.setString('currencyList', res);
  }

  Map<String, String>? getCurrencyList() {
    final val = sharedPreferences.getString('currencyList');
    if (val == null || val.isEmpty) return null;
    return Map<String, String>.from(jsonDecode(val));
  }

  Future<void> setCurrencyConvertingValue(
      Map<String, double>? exchangeRateVal) {
    String res = '';
    if (exchangeRateVal != null) {
      final val = getCurrencyConvertingValue();
      if (val != null || val!.isNotEmpty) {
        for (final item in exchangeRateVal.entries) {
          val.putIfAbsent(item.key, () => item.value);
        }
        res = jsonEncode(val);
        return sharedPreferences.setString('currencyExchangeRates', res);
      }
      res = jsonEncode(exchangeRateVal);
    }
    return sharedPreferences.setString('currencyExchangeRates', res);
  }

  Map<String, double>? getCurrencyConvertingValue() {
    final val = sharedPreferences.getString('currencyExchangeRates');
    if (val == null || val.isEmpty) return null;
    return Map<String, double>.from(jsonDecode(val));
  }

  /// Must be called when you want to remove all the user Info
  Future<void> clearInfo() async {
    await setCurrencyList(null);
    await setCurrencyConvertingValue(null);
  }
}
