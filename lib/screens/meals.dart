import 'package:flutter/material.dart';
import 'package:meals/main.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screens/meal_detaials.dart';
import 'package:meals/widgets/meal_item.dart';
class Meals extends StatelessWidget {
  const Meals({super.key,this.title,required this.meals,});

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context,Meal meal){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealDetailScreen(meal: meal,),),);
  }

  //MealItem(meal: meals[index],onSelectMeal: (meal){
  //selectMeal(context, meal);
  //},)

  @override
  Widget build(BuildContext context) {
    Widget content=ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx,index)=> MealItem(
          meal: meals[index],
          onSelectMeal: (BuildContext context, Meal meal) {
            selectMeal(context, meal);
          },
        ),

    );

    if(meals.isEmpty){
      content=Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('uh oh .... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            Text("try selecting a different category",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    if(title==null){
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body:content,
    );
  }
}
