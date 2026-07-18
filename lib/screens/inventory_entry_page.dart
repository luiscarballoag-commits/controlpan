import 'package:flutter/material.dart';

import '../models/ingredient_catalog.dart';
import '../models/inventory_movement.dart';
import '../services/ingredient_service.dart';
import '../services/inventory_movement_service.dart';

class InventoryEntryPage extends StatefulWidget {
  const InventoryEntryPage({super.key});

  @override
  State<InventoryEntryPage> createState() =>
      _InventoryEntryPageState();
}

class _InventoryEntryPageState
    extends State<InventoryEntryPage> {

  final IngredientService ingredientService =
      IngredientService();

  final InventoryMovementService movementService =
      InventoryMovementService();

  IngredientCatalog? selectedIngredient;
  int? selectedIndex;

  final _quantityController =
      TextEditingController();

  final _priceController =
      TextEditingController();

  final _supplierController =
      TextEditingController();

  final _invoiceController =
      TextEditingController();

  final _notesController =
      TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    _supplierController.dispose();
    _invoiceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboard =
        TextInputType.text,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 16,
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

  void saveEntry() {

    if (selectedIngredient == null ||
        selectedIndex == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Seleccione un ingrediente",
          ),
        ),
      );

      return;
    }

    final quantity =
        double.tryParse(
              _quantityController.text,
            ) ??
            0;

    final updatedIngredient =
        IngredientCatalog(
      id: selectedIngredient!.id,
      name: selectedIngredient!.name,
      category:
          selectedIngredient!.category,
      unit: selectedIngredient!.unit,
      purchasePrice:
          double.tryParse(
                _priceController.text,
              ) ??
              selectedIngredient!
                  .purchasePrice,
      stock:
          selectedIngredient!.stock +
              quantity,
      minimumStock:
          selectedIngredient!
              .minimumStock,
      notes:
          selectedIngredient!.notes,
    );

    ingredientService.updateIngredient(
      selectedIndex!,
      updatedIngredient,
    );    movementService.addMovement(
      InventoryMovement(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        date: DateTime.now(),
        ingredientId:
            updatedIngredient.id,
        ingredientName:
            updatedIngredient.name,
        quantity: quantity,
        unit: updatedIngredient.unit,
        type: "Entrada",
        reference:
            _invoiceController.text
                    .trim()
                    .isEmpty
                ? "Compra Manual"
                : _invoiceController.text,
        notes: _notesController.text,
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          "Se agregaron ${quantity.toStringAsFixed(2)} ${selectedIngredient!.unit} a ${selectedIngredient!.name}",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final ingredients =
        ingredientService
            .getAllIngredients();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Entrada de Inventario",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [

            DropdownButtonFormField<
                IngredientCatalog>(
              initialValue:
                  selectedIngredient,
              decoration:
                  const InputDecoration(
                labelText:
                    "Ingrediente",
                border:
                    OutlineInputBorder(),
              ),
              items: List.generate(
                ingredients.length,
                (index) {
                  final ingredient =
                      ingredients[index];                  return DropdownMenuItem<
                      IngredientCatalog>(
                    value: ingredient,
                    child: Text(
                      ingredient.name,
                    ),
                  );
                },
              ),
              onChanged: (value) {
                setState(() {
                  selectedIngredient = value;

                  if (value != null) {
                    selectedIndex =
                        ingredients.indexOf(
                      value,
                    );
                  }
                });
              },
            ),

            const SizedBox(height: 16),

            buildField(
              "Cantidad",
              _quantityController,
              keyboard:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),
            ),

            buildField(
              "Precio Unitario",
              _priceController,
              keyboard:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),
            ),

            buildField(
              "Proveedor",
              _supplierController,
            ),

            buildField(
              "Número de Factura",
              _invoiceController,
            ),

            buildField(
              "Observaciones",
              _notesController,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.save,
                ),
                label: const Text(
                  "REGISTRAR ENTRADA",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: saveEntry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
