import 'package:flutter/material.dart';

import '../models/ingredient_catalog.dart';
import '../services/ingredient_service.dart';

class IngredientEditorPage extends StatefulWidget {
  const IngredientEditorPage({super.key});

  @override
  State<IngredientEditorPage> createState() =>
      _IngredientEditorPageState();
}

class _IngredientEditorPageState extends State<IngredientEditorPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _minimumController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedCategory;
  String? _selectedUnit;

  final List<String> _categories = [
    'Harinas',
    'Azúcares',
    'Grasas',
    'Lácteos',
    'Levaduras',
    'Mejoradores',
    'Esencias',
    'Sales',
    'Líquidos',
    'Otros',
  ];

  final List<String> _units = [
    'kg',
    'g',
    'L',
    'ml',
    'Unidad',
    'Caja',
    'Saco',
  ];

  final IngredientService ingredientService = IngredientService();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _minimumController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void saveIngredient() {
    if (_nameController.text.trim().isEmpty) return;

    final ingredient = IngredientCatalog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      category: _selectedCategory ?? '',
      unit: _selectedUnit ?? '',
      purchasePrice:
          double.tryParse(_priceController.text) ?? 0,
      stock:
          double.tryParse(_stockController.text) ?? 0,
      minimumStock:
          double.tryParse(_minimumController.text) ?? 0,
      notes: _notesController.text.trim(),
    );

    ingredientService.addIngredient(ingredient);

    Navigator.pop(context);
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Ingrediente"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            buildField(
              "Nombre",
              _nameController,
              icon: Icons.inventory_2,
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Categoría",
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: DropdownButtonFormField<String>(
                initialValue: _selectedUnit,
                decoration: const InputDecoration(
                  labelText: "Unidad",
                  prefixIcon: Icon(Icons.straighten),
                  border: OutlineInputBorder(),
                ),
                items: _units.map((unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUnit = value;
                  });
                },
              ),
            ),

            buildField(
              "Precio de compra",
              _priceController,
              keyboard: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              icon: Icons.attach_money,
            ),

            buildField(
              "Stock actual",
              _stockController,
              keyboard: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              icon: Icons.warehouse,
            ),            buildField(
              "Stock mínimo",
              _minimumController,
              keyboard: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              icon: Icons.warning_amber_rounded,
            ),

            buildField(
              "Observaciones",
              _notesController,
              icon: Icons.notes,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: saveIngredient,
                icon: const Icon(Icons.save),
                label: const Text(
                  "GUARDAR INGREDIENTE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
