import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      // if meal already exists in list, REMOVE FROM THE LIST, so create a list where the meals don't match the new meal id
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // if meal doesn't exist in the favorite list, ADD IT TO THE LIST
      state = [...state, meal];
      return true;
    }
  }
}

//this will return an instance of the FavoriteMealsNotifier class
//this instance provides both data and methods to mutate it
//we have to specify the type of data it returns others wise this provider doesn't know about it so we add in specific types (as its a generic method)
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
