import 'package:hive_flutter/hive_flutter.dart';

class SettingsService {
  static const String _boxName = 'settings';

  static const String bakeryNameKey = 'bakery_name';

  Box get _box => Hive.box(_boxName);

  String get bakeryName {
    return _box.get(
          bakeryNameKey,
          defaultValue: 'Panadería y Pastelería Carballog FP',
        )
        as String;
  }

  Future<void> saveBakeryName(String name) async {
    await _box.put(bakeryNameKey, name);
  }
}
