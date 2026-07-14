import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/ingredient_catalog.dart';
import 'screens/dashboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(IngredientCatalogAdapter());

  await Hive.openBox<IngredientCatalog>('ingredients');
  await Hive.openBox('recipes');
  await Hive.openBox('inventory');
  await Hive.openBox('productions');
  await Hive.openBox('costs');
  await Hive.openBox('settings');

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
