
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/view_models/home.viewmodel.dart';
import 'package:provider/provider.dart';

import 'selectCurrency.view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel viewModel;
  late TextEditingController controller;
  String? amount;

  @override
  void initState() {
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    controller = TextEditingController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   viewModel.fetchCurrencyData();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (_, model, child) {
        String from = model.fromCurrency;
        String to = model.toCurrency;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Convert Currency",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Enter Amount',
                      label: const Text('Enter Amount'),
                    ),
                    keyboardType: TextInputType.number),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('FROM'),
                        MaterialButton(
                          onPressed: () {
                            model.setFrom = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const SelectCurrencyPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            width: 100,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text('$from'),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        model.swapFromTo();
                      },
                      icon: Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.swap_horiz,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                    Column(
                      children: [
                        Text('TO'),
                        MaterialButton(
                          onPressed: () {
                            model.setFrom = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const SelectCurrencyPage()));
                          },
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text('$to'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Select Amount')));
                    } else if (model.fromCurrency == 'Select') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Select from')));
                    } else if (model.toCurrency == 'Select') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Select to')));
                    } else {
                      model.fetchCurrencyConvertData();
                    }
                  },
                  child: const Text(
                    'Calculate',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
                const SizedBox(height: 24),
                model.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Text(model.exchangeMultiple == 0.0
                        ? ''
                        : 'RESULT : ${model.exchangeMultiple * double.parse(controller.text)}'),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
      child: Container(),
    );
  }
}
