
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class StartUp
{
  static void setup()async {
    await AppSharedPreferences.init();
  }
}
