import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/ingredient_catalog.dart';
import 'screens/dashboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(IngredientCatalogAdapter());
  }

  if (!Hive.isBoxOpen('ingredients')) {
    await Hive.openBox<IngredientCatalog>('ingredients');
  }

  if (!Hive.isBoxOpen('recipes')) {
    await Hive.openBox('recipes');
  }

  if (!Hive.isBoxOpen('inventory')) {
    await Hive.openBox('inventory');
  }

  if (!Hive.isBoxOpen('productions')) {
    await Hive.openBox('productions');
  }

  if (!Hive.isBoxOpen('costs')) {
    await Hive.openBox('costs');
  }

  if (!Hive.isBoxOpen('settings')) {
    await Hive.openBox('settings');
  }

  runApp(const ControlPanApp());
}

class ControlPanApp extends StatelessWidget {
  const ControlPanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ControlPan',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF8D6E63),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}
