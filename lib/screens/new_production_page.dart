import 'package:flutter/material.dart';

import '../core/production_engine/production_calculator.dart';
import '../models/production.dart';
import '../services/production_service.dart';

class NewProductionPage extends StatefulWidget {
  const NewProductionPage({super.key});

  @override
  State<NewProductionPage> createState() =>
      _NewProductionPageState();
}

class _NewProductionPageState
    extends State<NewProductionPage> {
  final ProductionService productionService =
      ProductionService();

  final TextEditingController flourController =
      TextEditingController();

  final TextEditingController waterController =
      TextEditingController();

  final TextEditingController sugarController =
      TextEditingController();

  final TextEditingController saltController =
      TextEditingController();

  final TextEditingController yeastController =
      TextEditingController();

  final TextEditingController fatController =
      TextEditingController();

  final TextEditingController butterController =
      TextEditingController();

  final TextEditingController pieceWeightController =
      TextEditingController();

  @override
  void dispose() {
    flourController.dispose();
    waterController.dispose();
    sugarController.dispose();
    saltController.dispose();
    yeastController.dispose();
    fatController.dispose();
    butterController.dispose();
    pieceWeightController.dispose();

    super.dispose();
  }  Widget buildField(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType:
            const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void calculateProduction() {
    final result =
        ProductionCalculator.calculate(
      flourKg:
          double.tryParse(flourController.text) ??
              0,
      waterLiters:
          double.tryParse(waterController.text) ??
              0,
      sugarGrams:
          double.tryParse(sugarController.text) ??
              0,
      saltGrams:
          double.tryParse(saltController.text) ??
              0,
      yeastGrams:
          double.tryParse(yeastController.text) ??
              0,
      fatGrams:
          double.tryParse(fatController.text) ??
              0,
      butterGrams:
          double.tryParse(butterController.text) ??
              0,
      pieceWeightGrams:
          double.tryParse(
                pieceWeightController.text,
              ) ??
              0,
    );

    final production = Production(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      date: DateTime.now(),
      recipeId: "",
      recipeName: "Producción Manual",
      lots: 1,
      totalMassKg: result.totalMass / 1000,
      pieceWeightGrams:
          result.pieceWeight,
      totalPieces:
          result.totalPieces,
    );

    productionService.addProduction(
      production,
    );

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
        title: const Text(
          "Producción Registrada",
        ),
        content: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Text(
              "Masa Total: ${production.totalMassKg.toStringAsFixed(2)} kg",
            ),
            const SizedBox(height: 8),
            Text(
              "Cantidad de Panes: ${production.totalPieces}",
            ),
            const SizedBox(height: 8),
            Text(
              "Peso por Pan: ${production.pieceWeightGrams.toStringAsFixed(0)} g",
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(
                    context),
            child:
                const Text("Aceptar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Producción Inteligente",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [            buildField(
              "Harina (kg)",
              flourController,
            ),

            buildField(
              "Agua (L)",
              waterController,
            ),

            buildField(
              "Azúcar (g)",
              sugarController,
            ),

            buildField(
              "Sal (g)",
              saltController,
            ),

            buildField(
              "Levadura (g)",
              yeastController,
            ),

            buildField(
              "Manteca Vegetal (g)",
              fatController,
            ),

            buildField(
              "Mantequilla (g)",
              butterController,
            ),

            const SizedBox(height: 20),

            buildField(
              "Peso por Pan (g)",
              pieceWeightController,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: calculateProduction,
                child: const Text(
                  "INICIAR PRODUCCIÓN",
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
