import 'package:flutter/material.dart';
import '../services/ingredient_service.dart';
import 'ingredient_editor_page.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final IngredientService ingredientService = IngredientService();

  @override
  Widget build(BuildContext context) {
    final ingredients = ingredientService.getAllIngredients();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo de Ingredientes"),
        centerTitle: true,
      ),
      body: ingredients.isEmpty
          ? const Center(
              child: Text(
                "Aún no tienes ingredientes.\n\nPulsa + para crear el primero.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.inventory_2),
                    ),
                    title: Text(ingredient.name),
                    subtitle: Text(
                      "${ingredient.category} • ${ingredient.unit}",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const IngredientEditorPage(),
            ),
          );

          setState(() {});
        },
      ),
    );
  }
}
