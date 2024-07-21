

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavoriteMealsNotifier():super([]);

  bool toggleMealFavoriteStatus(Meal meal){
    final mealIsFavorite=state.contains(meal);

    if(mealIsFavorite){
      //state.add(meal);//not allowed because we are mutating the state and it is not possible int the case of the state
      state=state.where((m)=>m.id!=meal.id).toList();//if this where method is true then it add the element otherwise it remove it.
      return false;
    }
    else{
      state=[...state,meal];
      return true;
    }


  }
}

final favoriteMealsProvider=StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref){
  return FavoriteMealsNotifier();
});