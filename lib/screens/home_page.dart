import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/settings_service.dart';
import 'dashboard_page.dart';
import 'inventory_page.dart';
import 'costs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SettingsService settingsService = SettingsService();

  int _selectedIndex = 0;

  final List<String> _titles = [
    'Inicio',
    'Inventario',
    'Producción',
    'Costos',
    'Reportes',
  ];

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "🌅 Buenos días";
    } else if (hour < 18) {
      return "☀️ Buenas tardes";
    } else {
      return "🌙 Buenas noches";
    }
  }

  String getMessage() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Todo listo para comenzar una excelente jornada de producción.";
    } else if (hour < 18) {
      return "La producción continúa. ¡Que tengas una excelente jornada!";
    } else {
      return "Buen trabajo hoy. Revisa los indicadores antes de finalizar la jornada.";
    }
  }

  String getDate() {
    return DateFormat(
      "EEEE, d 'de' MMMM 'de' y",
      "es",
    ).format(DateTime.now());
  }

  String getTime() {
    return DateFormat(
      "hh:mm a",
      "es",
    ).format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
        backgroundColor: const Color(0xFF8D6E63),
        foregroundColor: Colors.white,
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeDashboard(
            greeting: getGreeting(),
            bakeryName: settingsService.bakeryName,
            message: getMessage(),
            currentDate: getDate(),
            currentTime: getTime(),
          ),
          InventoryPage(),
          DashboardPage(),
          const CostsPage(),
          const ReportsPage(),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Inicio",
          ),

          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: "Inventario",
          ),

          NavigationDestination(
            icon: Icon(Icons.bakery_dining_outlined),
            selectedIcon: Icon(Icons.bakery_dining),
            label: "Producción",
          ),

          NavigationDestination(
            icon: Icon(Icons.attach_money_outlined),
            selectedIcon: Icon(Icons.attach_money),
            label: "Costos",
          ),

          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: "Reportes",
          ),
        ],
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {

  final String greeting;
  final String bakeryName;
  final String message;
  final String currentDate;
  final String currentTime;

  const HomeDashboard({
    super.key,
    required this.greeting,
    required this.bakeryName,
    required this.message,
    required this.currentDate,
    required this.currentTime,
  });

  @override
  Widget build(BuildContext context) {    return ListView(
      padding: const EdgeInsets.all(16),
      children: [

        Text(
          greeting,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          bakeryName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8D6E63),
          ),
        ),

        const SizedBox(height: 20),

        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.calendar_month,
              color: Color(0xFF8D6E63),
            ),
            title: Text(
              currentDate,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.access_time,
              color: Color(0xFF8D6E63),
            ),
            title: Text(
              currentTime,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Card(
          color: const Color(0xFFFFF8E1),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [

                const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/images/dashboard_banner.png",
            height: 180,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          "Resumen del día",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),        _summaryCard(
          Icons.inventory_2,
          "Ingredientes",
          "0",
          Colors.orange,
        ),

        _summaryCard(
          Icons.bakery_dining,
          "Producciones",
          "0",
          Colors.brown,
        ),

        _summaryCard(
          Icons.attach_money,
          "Costo promedio",
          "\$0.00",
          Colors.green,
        ),

        _summaryCard(
          Icons.warning_amber_rounded,
          "Alertas",
          "0",
          Colors.red,
        ),

        const SizedBox(height: 30),

        Center(
          child: Text(
            "ControlPan v1.0\nLa forma inteligente de gestionar tu panadería",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _summaryCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Reportes\n\nPróximamente",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
