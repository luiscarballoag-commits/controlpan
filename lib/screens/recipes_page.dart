import 'package:flutter/material.dart';
import '../services/recipe_service.dart';
import 'recipe_editor_page.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final RecipeService recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    final recipes = recipeService.getAllRecipes();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Recetas"),
        centerTitle: true,
      ),
      body: recipes.isEmpty
          ? const Center(
              child: Text(
                "Aún no tienes recetas.\n\nPulsa + para crear la primera.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.menu_book),
                    ),
                    title: Text(recipe.name),
                    subtitle: Text(
                      "${recipe.ingredients.length} ingredientes",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Nueva receta"),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RecipeEditorPage(),
            ),
          );

          setState(() {});
        },
      ),
    );
  }
}
