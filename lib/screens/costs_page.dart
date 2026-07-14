import 'package:flutter/material.dart';

class CostsPage extends StatelessWidget {
  const CostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),
      appBar: AppBar(
        title: const Text("Costos Inteligentes"),
        centerTitle: true,
        backgroundColor: const Color(0xFF8D6E63),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _buildCard(
            Icons.shopping_basket,
            "Materia Prima",
            "\$0.00",
            Colors.orange,
          ),

          _buildCard(
            Icons.local_fire_department,
            "Producción",
            "\$0.00",
            Colors.red,
          ),

          _buildCard(
            Icons.groups,
            "Mano de Obra",
            "\$0.00",
            Colors.blue,
          ),

          _buildCard(
            Icons.business,
            "Gastos Operativos",
            "\$0.00",
            Colors.green,
          ),

          _buildCard(
            Icons.precision_manufacturing,
            "Depreciación",
            "\$0.00",
            Colors.deepPurple,
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [

                  Text(
                    "Costo Total",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "\$0.00",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calculate),
              label: const Text(
                "CALCULAR COSTOS",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {},
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
