import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'repository/currency_repo.dart';
import 'shared_pref_manager.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerFactory<CurrencyRepo>(() => CurrencyRepoImpl());
  final prefs = await SharedPreferences.getInstance();
  final manager = SharedPrefManager(prefs);
  locator.registerSingleton<SharedPrefManager>(manager);
}
