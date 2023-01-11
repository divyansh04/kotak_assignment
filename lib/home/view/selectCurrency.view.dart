import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/home.viewmodel.dart';

class SelectCurrencyPage extends StatefulWidget {
  const SelectCurrencyPage({super.key});

  @override
  _SelectCurrencyState createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrencyPage> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<HomeViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchCurrencyData();
    });
    super.initState();
    // _initPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Currency",
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (_, model, child) {
          if (model.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (model.currencyList == null ||
              model.currencyList!.isEmpty) {
            return const Text('Data Not Available.');
          } else {
            Map<String, String>? currencyList = model.currencyList;
            model.setFrom
                ? currencyList?.remove(model.toCurrency)
                : currencyList?.remove(model.fromCurrency);
            List<String> currencyAbrev = [];
            List<String> currency = [];
            currencyList!.forEach((key, value) {
              currencyAbrev.add(key);
              currency.add(value);
            });

            return Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
              child: Container(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: ListView.builder(
                        itemCount: currencyAbrev.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              model.setFrom
                                  ? model.setFromCurrency(currencyAbrev[index])
                                  : model.setToCurrency(currencyAbrev[index]);
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              height: 42.0,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(currencyAbrev[index]),
                                        ],
                                      ),
                                      Text(
                                        currency[index],
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
