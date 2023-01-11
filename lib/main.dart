import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/service/repository/currency_repo.dart';
import 'home/view/home.view.dart';
import 'home/view_models/home.viewmodel.dart';
import 'home/service/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT SERVICE LOCATOR
  await setupLocator();

  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(repo: locator<CurrencyRepo>()),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screener',
      home: HomeView(),
    );
  }
}