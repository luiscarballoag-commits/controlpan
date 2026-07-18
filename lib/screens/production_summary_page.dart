import 'package:flutter/material.dart';

import '../models/production.dart';
import '../models/recipe.dart';
import '../models/recipe_ingredient.dart';
import '../services/production_inventory_service.dart';
import '../services/production_service.dart';

class ProductionSummaryPage extends StatefulWidget {
  final Recipe recipe;
  final double lots;
  final double pieceWeight;

  const ProductionSummaryPage({
    super.key,
    required this.recipe,
    required this.lots,
    required this.pieceWeight,
  });

  @override
  State<ProductionSummaryPage> createState() =>
      _ProductionSummaryPageState();
}

class _ProductionSummaryPageState
    extends State<ProductionSummaryPage> {

  final ProductionService productionService =
      ProductionService();

  final ProductionInventoryService
      inventoryService =
      ProductionInventoryService();

  double totalMassGrams = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalMass();
  }

  void calculateTotalMass() {
    totalMassGrams = 0;

    for (final RecipeIngredient ingredient
        in widget.recipe.ingredients) {
      totalMassGrams +=
          ingredient.quantity * widget.lots;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPieces =
        widget.pieceWeight > 0
            ? (totalMassGrams /
                    widget.pieceWeight)
                .floor()
            : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Resumen de Producción",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.menu_book,
                ),
                title: Text(
                  widget.recipe.name,
                ),
                subtitle: Text(
                  "${widget.lots.toStringAsFixed(0)} lote(s)",
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                "Ingredientes necesarios",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount:
                    widget.recipe
                        .ingredients
                        .length,
                itemBuilder:
                    (context, index) {
                  final ingredient =
                      widget
                          .recipe
                          .ingredients[index];

                  final quantity =
                      ingredient.quantity *
                          widget.lots;

                  return Card(
                    child: ListTile(
                      leading:
                          const Icon(
                        Icons.inventory,
                      ),
                      title: Text(
                        ingredient.name,
                      ),
                      subtitle: Text(
                        "${quantity.toStringAsFixed(2)} ${ingredient.unit}",
                      ),
                    ),
                  );
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.scale,
                ),
                title: const Text(
                  "Masa Total",
                ),
                trailing: Text(
                  "${(totalMassGrams / 1000).toStringAsFixed(2)} kg",
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.bakery_dining,
                ),
                title: const Text(
                  "Panes estimados",
                ),
                trailing: Text(
                  "$totalPieces",
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.play_arrow,
                ),
                label: const Text(
                  "INICIAR PRODUCCIÓN",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                onPressed: () {                  if (!inventoryService
                      .hasEnoughInventory(
                    recipe: widget.recipe,
                    lots: widget.lots,
                  )) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "No hay suficiente inventario para realizar esta producción.",
                        ),
                      ),
                    );
                    return;
                  }

                  inventoryService
                      .consumeIngredients(
                    recipe: widget.recipe,
                    lots: widget.lots,
                  );

                  productionService
                      .addProduction(
                    Production(
                      id: DateTime.now()
                          .millisecondsSinceEpoch
                          .toString(),
                      date: DateTime.now(),
                      recipeId:
                          widget.recipe.id,
                      recipeName:
                          widget.recipe.name,
                      lots:
                          widget.lots.toInt(),
                      totalMassKg:
                          totalMassGrams /
                              1000,
                      pieceWeightGrams:
                          widget.pieceWeight,
                      totalPieces:
                          totalPieces,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Producción registrada correctamente.",
                      ),
                    ),
                  );

                  Navigator.popUntil(
                    context,
                    (route) =>
                        route.isFirst,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
