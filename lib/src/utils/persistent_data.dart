import "dart:collection";
import "dart:convert";

import "package:shared_preferences/shared_preferences.dart";

class PersistentData {
  static final HashMap<String, PersistentData> _instances = new HashMap();

  String name;
  dynamic data;


  // ================================================================================================================
  // STATIC INTERFACE -----------------------------------------------------------------------------------------------

  static PersistentData get(String name) {
    if (_instances.containsKey(name)) {
      return _instances[name];
    }

    PersistentData persistentData = new PersistentData(name);
    _instances[name] = persistentData;
    return persistentData;
  }

  static resetForTests() {
    SharedPreferences.setMockInitialValues({});
  }


  // ================================================================================================================
  // CONSTRUCTOR ----------------------------------------------------------------------------------------------------

  PersistentData(this.name) {
    _read();
  }


  // ================================================================================================================
  // PUBLIC INTERFACE -----------------------------------------------------------------------------------------------

  Future<void> read() async {
    await _read();
  }

  String getString(String name, [String defaultValue = ""]) {
    assert(isInitialized(), "Attempting to read uninitialized data");

    try {
      var value = data[name];
      if (value is String) return value;
    } catch(RuntimeBinderException) {
    }

    return defaultValue;
  }

  void setString(String name, String value) {
    assert(isInitialized(), "Attempting to read uninitialized data");

    data[name] = value;
    _write();
  }

  bool isInitialized() {
    return data != null;
  }


  // ================================================================================================================
  // PRIVATE INTERFACE ----------------------------------------------------------------------------------------------

  Future<void> _read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataSrc = prefs.getString(name) ?? "{}";
    data = json.decode(dataSrc);
  }

  Future<void> _write() async {
    if (data != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(name, json.encode(data));
    }
  }
}
