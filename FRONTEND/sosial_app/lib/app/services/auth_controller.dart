import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosial_app/app/model/authModel.dart';

class AuthController extends GetxController {
  Rx<Authmodel?> userBio = Rx<Authmodel?>(null);

  Future<void> setUser(Authmodel user) async{
    userBio.value = user;
    await savetoPref(user);
  }

  Future<void> savetoPref(Authmodel user) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(
      'user_data',
      jsonEncode({
        'id': user.id,
        'username': user.username,
        'email': user.email,
      }),
    );
  }

  Future<void> loadDataUser() async {
    final pref = await SharedPreferences.getInstance();
    final raw = pref.getString('user_data');
    if (raw != null) {
      final map = jsonDecode(raw);
      userBio.value = Authmodel(
        id: map['id'],
        username: map['username'],
        email: map['email'],
      );
    }
  }

  Future<void> clearUser() async{
    userBio.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }
}
