import 'package:shared_preferences/shared_preferences.dart';

class PersistenceHandler {
  static void setter(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<dynamic> getter(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? null;
  }

  static deleteStore(String keyToDelete) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();

    var it = keys.iterator;
    while (it.moveNext()) {
      String key = it.current;
      if (key == keyToDelete) {
        prefs.remove(key);
      }
    }
  }
}
