import 'package:flutter/material.dart';

import '../models/ingredient_catalog.dart';
import '../models/recipe.dart';
import '../models/recipe_ingredient.dart';
import '../services/recipe_service.dart';
import 'select_ingredient_page.dart';

class RecipeEditorPage extends StatefulWidget {
  const RecipeEditorPage({super.key});

  @override
  State<RecipeEditorPage> createState() => _RecipeEditorPageState();
}

class _RecipeEditorPageState extends State<RecipeEditorPage> {
  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _descriptionController =
      TextEditingController();

  final RecipeService recipeService = RecipeService();

  final List<RecipeIngredient> ingredients = [];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> addIngredient() async {
    final IngredientCatalog? ingredient =
        await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SelectIngredientPage(),
      ),
    );

    if (ingredient == null) return;

    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ingredient.name),
          content: TextField(
            controller: controller,
            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: InputDecoration(
              labelText:
                  "Cantidad (${ingredient.unit})",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final quantity =
                    double.tryParse(controller.text) ??
                        0;

                setState(() {
                  ingredients.add(
                    RecipeIngredient(
                      ingredient: ingredient,
                      quantity: quantity,
                    ),
                  );
                });

                Navigator.pop(context);
              },
              child: const Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  void saveRecipe() {
    final recipe = Recipe(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      name: _nameController.text,
      description: _descriptionController.text,
      ingredients: ingredients,
    );

    recipeService.addRecipe(recipe);

    Navigator.pop(context);
  }

  Widget buildField(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border:
              const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva Receta"),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildField(
              "Nombre de la receta",
              _nameController,
            ),

            buildField(
              "Descripción",
              _descriptionController,
            ),

            const SizedBox(height: 16),

            const Text(
              "Ingredientes",
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            if (ingredients.isEmpty)
              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(16),
                  child: Text(
                    "Todavía no hay ingredientes.",
                  ),
                ),
              ),

            ...ingredients.map(
              (item) => Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.inventory,
                  ),
                  title: Text(item.name),
                  subtitle: Text(
                    "${item.quantity} ${item.unit}",
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 55,
              child: OutlinedButton.icon(
                onPressed: addIngredient,
                icon: const Icon(Icons.add),
                label: const Text(
                  "AGREGAR INGREDIENTE",
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: saveRecipe,
                child: const Text(
                  "GUARDAR RECETA",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
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
