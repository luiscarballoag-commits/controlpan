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

  final IngredientService ingredientService =
      IngredientService();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  void saveIngredient() {
    if (_nameController.text.trim().isEmpty) return;

    final ingredient = IngredientCatalog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      category: _categoryController.text.trim(),
      unit: _unitController.text.trim(),
    );

    ingredientService.addIngredient(ingredient);

    Navigator.pop(context);
  }

  Widget buildField(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
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
              "Nombre del ingrediente",
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
