import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/src/login/login_state.dart';

import '../../utils/shared_preferences_keys.dart';

class LoginController {
  LoginState state = LoginStateEmpty();

  Future<LoginState> login({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 2));

    await prefs.setString(SharedPreferencesKeys.userName, email);

    return LoginStateSuccess();
  }
}
