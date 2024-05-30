import 'dart:convert';

import 'package:barber/models/models.dart';
import 'package:barber/utils/utils.dart';

class UserRepository {
  User? _user;

  User get user => _user!;

  Future<User?> get() async {
    Map<String, dynamic> values = json.decode(await Prefs.getString(PrefsKeys.userProperty) ?? '');

    _user ??= User.fromMap(values['id'], values);

    return _user;
  }

  Future<void> setUser(String id, Map<String, dynamic> values) async {
    _user = User.fromMap(id, values);

    Map<String, dynamic> userJson = {'id': _user?.id, ..._user?.toMap() ?? {}};

    await Prefs.setString(PrefsKeys.userProperty, json.encode(userJson));
  }
}
