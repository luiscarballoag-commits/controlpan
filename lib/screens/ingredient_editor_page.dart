import 'package:flutter/material.dart';

import '../models/ingredient_catalog.dart';
import '../services/ingredient_service.dart';

class IngredientEditorPage extends StatefulWidget {
  const IngredientEditorPage({super.key});

  @override
  State<IngredientEditorPage> createState() =>
      _IngredientEditorPageState();
}

class _IngredientEditorPageState
    extends State<IngredientEditorPage> {

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _unitController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _minimumController = TextEditingController();
  final _notesController = TextEditingController();

  final IngredientService ingredientService =
      IngredientService();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _unitController.dispose();
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
      category: _categoryController.text.trim(),
      unit: _unitController.text.trim(),
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
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
            ),

            buildField(
              "Categoría",
              _categoryController,
            ),

            buildField(
              "Unidad (kg, g, L, ml, und...)",
              _unitController,
            ),

            buildField(
              "Precio de compra",
              _priceController,
              keyboard: const TextInputType.numberWithOptions(decimal: true),
            ),

            buildField(
              "Stock actual",
              _stockController,
              keyboard: const TextInputType.numberWithOptions(decimal: true),
            ),

            buildField(
              "Stock mínimo",
              _minimumController,
              keyboard: const TextInputType.numberWithOptions(decimal: true),
            ),

            buildField(
              "Observaciones",
              _notesController,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: saveIngredient,
                child: const Text(
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
