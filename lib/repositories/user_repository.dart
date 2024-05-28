import 'dart:convert';

import 'package:barber/models/models.dart';
import 'package:barber/utils/utils.dart';

class UserRepository {
  User? _user;

  Future<User?> get() async {
    _user ??= User.fromMap((json.decode(await Prefs.getString(PrefsKeys.userProperty) ?? '')));

    return _user;
  }

  Future<void> setUser(String jsonUser) async {
    _user = User.fromMap(json.decode(jsonUser));
    
    await Prefs.setString(PrefsKeys.userProperty, json.encode(jsonUser));
  }
}
