
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/model/exchange_rate_model.dart';
import 'package:flutter_application_1/home/service/locator.dart';
import 'package:flutter_application_1/home/service/shared_pref_manager.dart';
import 'package:http/http.dart' as http;

import '../service/repository/currency_repo.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel({
    required this.repo,
  });

  final CurrencyRepo repo;

  bool isLoading = false;

  Map<String, String>? _currencyList;
  Map<String, double>? _exchangeRateList;
  ExchangeRateModel _exchangeRateModelResult = ExchangeRateModel();

  ExchangeRateModel get currencyConvertResult => _exchangeRateModelResult;

  String _from = 'Select';
  String _to = 'Select';

  bool setFrom = true;

  String get fromCurrency => _from;
  String get toCurrency => _to;

  setFromCurrency(String cur) {
    _from = cur;
    notifyListeners();
  }

  setToCurrency(String cur) {
    _to = cur;
    notifyListeners();
  }

  swapFromTo() {
    String temp;
    temp = _from;
    _from = _to;
    _to = temp;

    exchangeMultiple = 0.0;
    notifyListeners();
  }

  Map<String, String>? get currencyList => _currencyList;
  Map<String, double>? get exchangeRateList => _exchangeRateList;

  Future<void> fetchCurrencyData() async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, String>? localData =
          locator.get<SharedPrefManager>().getCurrencyList();

      if (localData == null || localData.isEmpty) {
        final apidata = await repo.fetchCurrencyList(http.Client());
        if (apidata.success == true) {
          _currencyList = apidata.symbols;
          locator.get<SharedPrefManager>().setCurrencyList(_currencyList);
        }
      } else {
        _currencyList = localData;
      }
    } catch (exc) {
      debugPrint('Error in _fetchData : ${exc.toString()}');
    }

    isLoading = false;
    notifyListeners();
  }

  double exchangeMultiple = 0.0;

  Future<void> fetchCurrencyConvertData() async {
    isLoading = true;
    notifyListeners();
    try {
      // Map<String, double>? localData =
      //     locator.get<SharedPrefManager>().getCurrencyConvertingValue();
      // if (localData == null || !localData.containsKey(toCurrency)) {
      _exchangeRateModelResult =
          await repo.fetchConversionResult(_from, _to, http.Client());
      //   if (_exchangeRateModelResult.success == true) {}
      exchangeMultiple = _exchangeRateModelResult.rates?[toCurrency] ?? 0.0;
      // }
    } catch (exc) {
      debugPrint('Error in _fetchData : ${exc.toString()}');
    }

    isLoading = false;
    notifyListeners();
  }
}
