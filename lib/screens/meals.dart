import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

import 'meal_detail.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onToggleFavorite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void _selectMeal(BuildContext context, Meal meal) {
    // load diff screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDetailScreen(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: () {
            _selectMeal(context, meals[index]);
          }),
    );

    if (meals.isEmpty) {
      content = Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )),
        const SizedBox(height: 16),
        Text(
          "Try selecting a different category!",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ]));
    }

    if (title == null) {
      return content;
    }
    // if the title is not null this portion of the code will execute
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
