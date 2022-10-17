import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/src/authentication/splash_state.dart';
import 'package:todo_app/utils/shared_preferences_keys.dart';

class SplashController {
  SplashController();

  Future<SplashState> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString(SharedPreferencesKeys.userName);

    if (username != null && username.isNotEmpty) {
      return SplashStateAuthenticated(username);
    } else {
      return SplashStateUnauthenticated();
    }
  }
}
