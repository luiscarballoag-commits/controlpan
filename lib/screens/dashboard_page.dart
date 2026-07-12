import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8D6E63),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "ControlPan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFFD7B56D),
              child: Icon(
                Icons.bakery_dining,
                size: 50,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "La forma inteligente de gestionar tu panadería",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: const [

                  DashboardCard(
                    icon: Icons.add_circle_outline,
                    title: "Nueva Producción",
                  ),

                  DashboardCard(
                    icon: Icons.inventory_2_outlined,
                    title: "Inventario",
                  ),

                  DashboardCard(
                    icon: Icons.calculate_outlined,
                    title: "Calculadora",
                  ),

                  DashboardCard(
                    icon: Icons.attach_money,
                    title: "Costos",
                  ),

                  DashboardCard(
                    icon: Icons.bar_chart,
                    title: "Reportes",
                  ),

                  DashboardCard(
                    icon: Icons.settings,
                    title: "Configuración",
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

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
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
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
