import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class RecipeEditorPage extends StatefulWidget {
  const RecipeEditorPage({super.key});

  @override
  State<RecipeEditorPage> createState() => _RecipeEditorPageState();
}

class _RecipeEditorPageState extends State<RecipeEditorPage> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _pieceWeightController = TextEditingController();

  final RecipeService recipeService = RecipeService();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _pieceWeightController.dispose();
    super.dispose();
  }

  void saveRecipe() {
    final recipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      category: _categoryController.text,
      pieceWeight:
          double.tryParse(_pieceWeightController.text) ?? 0,
      ingredients: const [],
      notes: '',
    );

    recipeService.addRecipe(recipe);

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
        title: const Text("Nueva Receta"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            buildField(
              "Nombre de la receta",
              _nameController,
            ),

            buildField(
              "Categoría",
              _categoryController,
            ),

            buildField(
              "Peso por pieza (g)",
              _pieceWeightController,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: saveRecipe,
                child: const Text(
                  "GUARDAR RECETA",
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
