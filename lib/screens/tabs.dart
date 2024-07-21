import 'package:flutter/material.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters={
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegan:false,
  Filter.vegetarian:false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex=0;
  // final List<Meal>_favriteMeals=[];
  Map<Filter,bool> _selectedFilters=kInitialFilters;

  /*void _showInfoMsg(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:Text(message),
    ),
    );
  }*/

  /*void _toggleMealFavoriteStatus(Meal meal){
    final isExisting=_favriteMeals.contains(meal);//return true if it content meal in the list

    if (isExisting){
      setState(() {
        _favriteMeals.remove(meal);
      });
      _showInfoMsg('Meal is no Longer a favorite');
    }
    else{
      setState(() {
        _favriteMeals.add(meal);
      });
      _showInfoMsg('Mark as Favorite');
    }
  }*/


  void _selectedPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if(identifier=='filters'){
      final result=await Navigator.of(context).push<Map<Filter,bool>>
        (MaterialPageRoute(builder: (ctx)=> FiltersScreen(currentFilter: _selectedFilters,)
      )
      );
      //print(result);
      setState(() {
        _selectedFilters=result ?? kInitialFilters;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    final meals=ref.watch(mealsProvider);
    final availableMeal=meals.where((meal){
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }
    ).toList();

    Widget activePage=CategoriesScreen(availableMeals: availableMeal,);
    var activePageTitle='Categories';

    if(_selectedPageIndex==1){
      final favoriteMeals=ref.watch(favoriteMealsProvider);
      activePage=Meals(
        meals: favoriteMeals,
      );
      activePageTitle='Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer:MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        selectedIconTheme: const IconThemeData(size: 35),
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.no_meals),label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourite')
        ],
      ),
    );
  }
}
