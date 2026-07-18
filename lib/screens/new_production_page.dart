import 'package:flutter/material.dart';

import '../services/dashboard_service.dart';
import 'production_recipe_page.dart';
import 'productions_page.dart';
import 'recipes_page.dart';

class NewProductionPage extends StatelessWidget {
  const NewProductionPage({super.key});

  Widget infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 34,
                color: const Color(0xFF8D6E63),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFF8D6E63),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {    final dashboard = DashboardService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Producción Inteligente",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Resumen de Hoy",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              infoCard(
                icon: Icons.factory,
                title: "Producciones",
                value: dashboard.productionsToday.toString(),
              ),

              const SizedBox(width: 12),

              infoCard(
                icon: Icons.scale,
                title: "Kg",
                value: dashboard.totalMassToday
                    .toStringAsFixed(1),
              ),

              const SizedBox(width: 12),

              infoCard(
                icon: Icons.bakery_dining,
                title: "Panes",
                value: dashboard.totalPiecesToday
                    .toString(),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "Operaciones",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          menuCard(
            context: context,
            icon: Icons.play_circle_fill,
            title: "Nueva Producción",
            subtitle:
                "Seleccionar una receta para producir.",
            page: const ProductionRecipePage(),
          ),

          menuCard(
            context: context,
            icon: Icons.menu_book,
            title: "Recetas",
            subtitle:
                "Administrar recetas de producción.",
            page: const RecipesPage(),
          ),

          menuCard(
            context: context,
            icon: Icons.history,
            title: "Historial",
            subtitle:
                "Consultar producciones realizadas.",
            page: const ProductionsPage(),
          ),

          menuCard(
            context: context,
            icon: Icons.calculate,
            title: "Producción Manual",
            subtitle:
                "Próximamente disponible.",
            page: const ProductionRecipePage(),
          ),
        ],
      ),
    );
  }
}
