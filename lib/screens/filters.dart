import 'package:flutter/material.dart';
import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/tabs.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key,required this.currentFilter});
  final Map<Filter,bool> currentFilter;

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {

  var _glutenFreeFilterSet=false;
  var _lactoseFreeFilterSet=false;
  var _vegetarianFilterSet=false;
  var _veganFilterSet=false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet=widget.currentFilter[Filter.glutenFree]!;
    _lactoseFreeFilterSet=widget.currentFilter[Filter.lactoseFree]!;
    _veganFilterSet=widget.currentFilter[Filter.vegan]!;
    _vegetarianFilterSet=widget.currentFilter[Filter.vegetarian]!;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      /*drawer: MainDrawer(onSelectScreen: (identifier) {
        Navigator.of(context).pop();
        if(identifier=='meals'){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const TabScreen()));
        }
      },
      ),*/
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if(didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(value: _glutenFreeFilterSet, onChanged: (isChecked){
              setState(() {
                _glutenFreeFilterSet=isChecked;
              });
            },
              title: Text('Gluten-Free',style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
              subtitle: Text('Only include gluten-free meals.',style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34,right: 22),
            ),
        
            SwitchListTile(value: _lactoseFreeFilterSet, onChanged: (isChecked){
              setState(() {
                _lactoseFreeFilterSet=isChecked;
              });
            },
              title: Text('Lactose-Free',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              ),
              subtitle: Text('Only include lactose-free meals.',style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34,right: 22),
            ),
        
            SwitchListTile(value: _vegetarianFilterSet, onChanged: (isChecked){
              setState(() {
                _vegetarianFilterSet=isChecked;
              });
            },
              title: Text('Vegetarian',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              ),
              subtitle: Text('Only include vegetarian meals.',style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34,right: 22),
            ),
        
            SwitchListTile(value: _veganFilterSet, onChanged: (isChecked){
              setState(() {
                _veganFilterSet=isChecked;
              });
            },
              title: Text('Vegan',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              ),
              subtitle: Text('Only include vegan meals.',style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34,right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
