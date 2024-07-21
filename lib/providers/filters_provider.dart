import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}
class FiltersNotifier extends StateNotifier<Map<Filter,bool>>{
  FiltersNotifier():super({
    Filter.vegetarian:false,
    Filter.lactoseFree:false,
    Filter.glutenFree:false,
    Filter.vegan:false,
  });

  void setFilters(Map<Filter,bool> chosenFilters){
    state=chosenFilters;
  }

  void setFilter(Filter filter,bool isActive){
    //state(filter)=isActive;  //not allowed ! => because we mutating the state
    state={
      ...state,//Expand the element is the previous state int the state map
      filter:isActive,
    };
  }
}

final filtersProvider= StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>(
    (ref)=>FiltersNotifier(),
);