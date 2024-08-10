import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_detail_Screen.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToogleFavorite;

  const MealsScreen({
    super.key,
    this.title,
    required this.meals, 
    required this.onToogleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return title == null
        ? content(context)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
             body: content(context),
          );
  }

  SingleChildScrollView content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: meals
            .map((meal) => MealItem(
                  meal: meal,
                  onSelectedMeal: (Meal meal) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => MealDetailScreen(
                          meal: meal,
                          onToogleFavorite: onToogleFavorite,
                        ),
                      ),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
