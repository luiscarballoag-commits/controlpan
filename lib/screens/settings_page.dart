import 'package:flutter/material.dart';

import '../widgets/settings/bakery_info_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        BakeryInfoCard(),

        SizedBox(height: 16),

        ListTile(
          leading: Icon(Icons.bakery_dining),
          title: Text("Producción"),
          subtitle: Text("Peso del pan y parámetros"),
        ),

        Divider(),

        ListTile(
          leading: Icon(Icons.attach_money),
          title: Text("Costos"),
          subtitle: Text("Moneda y configuración"),
        ),

        Divider(),

        ListTile(
          leading: Icon(Icons.backup),
          title: Text("Respaldo"),
          subtitle: Text("Exportar e importar datos"),
        ),

        Divider(),

        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text("Acerca de"),
          subtitle: Text("ControlPan versión 1.0"),
        ),
      ],
    );
  }
}
