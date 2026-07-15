import 'package:flutter/material.dart';

import '../models/ingredient_catalog.dart';
import '../services/ingredient_service.dart';

class IngredientEditorPage extends StatefulWidget {
  final IngredientCatalog? ingredient;
  final int? index;

  const IngredientEditorPage({
    super.key,
    this.ingredient,
    this.index,
  });

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

  String? selectedCategory;
  String? selectedUnit;

  final categories = [
    "Harinas",
    "Azúcares",
    "Grasas",
    "Levaduras",
    "Lácteos",
    "Esencias",
    "Mejoradores",
    "Otros",
  ];

  final units = [
    "kg",
    "g",
    "L",
    "ml",
    "Unidad",
    "Caja",
    "Saco",
  ];

  final IngredientService ingredientService =
      IngredientService();

  @override
  void initState() {
    super.initState();

    if (widget.ingredient != null) {

      _nameController.text =
          widget.ingredient!.name;

      selectedCategory =
          widget.ingredient!.category;

      selectedUnit =
          widget.ingredient!.unit;

      _priceController.text =
          widget.ingredient!.purchasePrice.toString();

      _stockController.text =
          widget.ingredient!.stock.toString();

      _minimumController.text =
          widget.ingredient!.minimumStock.toString();

      _notesController.text =
          widget.ingredient!.notes;
    }
  }

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
  }  void saveIngredient() {

    if (_nameController.text.trim().isEmpty) {
      return;
    }

    final ingredient = IngredientCatalog(
      id: widget.ingredient?.id ??
          DateTime.now()
              .millisecondsSinceEpoch
              .toString(),

      name: _nameController.text.trim(),

      category: selectedCategory ?? "",

      unit: selectedUnit ?? "",

      purchasePrice:
          double.tryParse(
                _priceController.text,
              ) ??
              0,

      stock:
          double.tryParse(
                _stockController.text,
              ) ??
              0,

      minimumStock:
          double.tryParse(
                _minimumController.text,
              ) ??
              0,

      notes: _notesController.text.trim(),
    );

    if (widget.index == null) {

      ingredientService.addIngredient(
        ingredient,
      );

    } else {

      ingredientService.updateIngredient(
        widget.index!,
        ingredient,
      );

    }

    Navigator.pop(context);
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboard =
        TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border:
              const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.index == null
              ? "Nuevo Ingrediente"
              : "Editar Ingrediente",
        ),
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

            DropdownButtonFormField<String>(
              initialValue: selectedCategory,
              decoration: const InputDecoration(
                labelText: "Categoría",
                border: OutlineInputBorder(),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              initialValue: selectedUnit,
              decoration: const InputDecoration(
                labelText: "Unidad",
                border: OutlineInputBorder(),
              ),
              items: units.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedUnit = value;
                });
              },
            ),

            const SizedBox(height: 14),

            buildField(
              "Precio de compra",
              _priceController,
              keyboard: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            buildField(
              "Stock actual",
              _stockController,
              keyboard: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            buildField(
              "Stock mínimo",
              _minimumController,
              keyboard: const TextInputType.numberWithOptions(
                decimal: true,
              ),
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
                child: Text(
                  widget.index == null
                      ? "GUARDAR INGREDIENTE"
                      : "ACTUALIZAR INGREDIENTE",
                  style: const TextStyle(
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
