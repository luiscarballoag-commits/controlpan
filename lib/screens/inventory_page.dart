import 'package:flutter/material.dart';
import '../services/inventory_service.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final InventoryService inventoryService = InventoryService();

  @override
  Widget build(BuildContext context) {
    final items = inventoryService.getAllItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventario"),
        centerTitle: true,
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                "El inventario está vacío.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          item.isLowStock ? Colors.red : Colors.green,
                      child: const Icon(
                        Icons.inventory_2,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(item.ingredientName),
                    subtitle: Text(
                      "Existencia: ${item.stock} ${item.unit}",
                    ),
                    trailing: item.isLowStock
                        ? const Icon(
                            Icons.warning,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                  ),
                );
              },
            ),
    );
  }
}
