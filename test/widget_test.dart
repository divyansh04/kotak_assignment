// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/model/currency_list_model.dart';
import 'package:flutter_application_1/home/service/repository/currency_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test("fetchCurrencyList", () async {
    final client = MockClient();

    when(client.get(
        Uri.parse('https://api.apilayer.com/exchangerates_data/symbols'),
        headers: {
          'apikey': 'VjkJgb9Azs2hy7TK2LUOVwIZhPwqNNnO'
        })).thenAnswer((_) async => http.Response(
        '{"success": true,"symbols": {"AED": "United Arab Emirates Dirham","AFN": "Afghan Afghani","ALL": "Albanian Lek","AMD": "Armenian Dram"}}',
        200));

    expect(await CurrencyRepoImpl().fetchCurrencyList(client),
        isA<CurrencyListModel>());
  });
}
