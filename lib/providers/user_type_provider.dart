import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTypeProvider extends StateNotifier<String> {
  UserTypeProvider() : super('') {
    loadUser();
  }

  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('user_role') ?? 'teacher';
  }

  Future<void> setUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', userType);
    state = userType;
  }
}

final userTypeProvider = StateNotifierProvider<UserTypeProvider, String>(
  (ref) => UserTypeProvider(),
);
