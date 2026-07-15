import 'package:flutter/material.dart';

import '../services/ingredient_service.dart';
import 'ingredient_editor_page.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() =>
      _IngredientsPageState();
}

class _IngredientsPageState
    extends State<IngredientsPage> {

  final IngredientService ingredientService =
      IngredientService();

  Future<void> deleteIngredient(
    int index,
  ) async {

    final confirm =
        await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Eliminar ingrediente",
        ),
        content: const Text(
          "¿Está seguro de eliminar este ingrediente?",
        ),
        actions: [

          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),

          ElevatedButton(
            onPressed: () =>
                Navigator.pop(context, true),
            child: const Text("Eliminar"),
          ),

        ],
      ),
    );

    if (confirm != true) return;

    ingredientService.deleteIngredient(index);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final ingredients =
        ingredientService.getAllIngredients();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Catálogo de Ingredientes",
        ),
        centerTitle: true,
      ),

      body: ingredients.isEmpty
          ? const Center(
              child: Text(
                "Aún no tienes ingredientes.\n\nPulsa + para crear el primero.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (
                context,
                index,
              ) {

                final ingredient =
                    ingredients[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [

                        ListTile(
                          contentPadding:
                              EdgeInsets.zero,
                          leading:
                              const CircleAvatar(
                            child: Icon(
                              Icons.inventory_2,
                            ),
                          ),
                          title: Text(
                            ingredient.name,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "${ingredient.category} • ${ingredient.unit}",
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [

                            Expanded(
                              child:
                                  OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.edit,
                                ),
                                label: const Text(
                                  "Editar",
                                ),
                                onPressed:
                                    () async {

                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          IngredientEditorPage(
                                        ingredient:
                                            ingredient,
                                        index: index,
                                      ),
                                    ),
                                  );

                                  setState(() {});

                                },
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child:
                                  ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                label: const Text(
                                  "Eliminar",
                                ),
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red,
                                  foregroundColor:
                                      Colors.white,
                                ),
                                onPressed: () {
                                  deleteIngredient(
                                    index,
                                  );
                                },
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),      floatingActionButton: FloatingActionButton(
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
