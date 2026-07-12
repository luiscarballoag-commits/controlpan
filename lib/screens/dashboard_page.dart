import 'package:flutter/material.dart';
import 'new_production_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),
      appBar: AppBar(
        title: const Text(
          'ControlPan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF8D6E63),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/controlpan_logo.jpg',
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "La forma inteligente de gestionar tu panadería",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  DashboardCard(
                    icon: Icons.add_circle_outline,
                    title: "Nueva Producción",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NewProductionPage(),
                        ),
                      );
                    },
                  ),
                  DashboardCard(
                    icon: Icons.inventory_2_outlined,
                    title: "Inventario",
                    onTap: () {},
                  ),
                  DashboardCard(
                    icon: Icons.calculate_outlined,
                    title: "Calculadora",
                    onTap: () {},
                  ),
                  DashboardCard(
                    icon: Icons.attach_money,
                    title: "Costos",
                    onTap: () {},
                  ),
                  DashboardCard(
                    icon: Icons.bar_chart,
                    title: "Reportes",
                    onTap: () {},
                  ),
                  DashboardCard(
                    icon: Icons.settings,
                    title: "Configuración",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: const Color(0xFF8D6E63),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
