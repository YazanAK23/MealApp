import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals_screen.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onToogleFavorite,
    required this.availableMeals,
  });

  final Category category;
  final void Function(Meal meal) onToogleFavorite;
  final List<Meal> availableMeals;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final List<Meal> filteredMeals = availableMeals.where(
          (meal) => meal.categories.contains(category.id),
        ).toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              onToogleFavorite: onToogleFavorite,
            ),
          ),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.52),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
