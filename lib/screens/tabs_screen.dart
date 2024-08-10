import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/data/dummy_data.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];
  Map<Filter, bool> _filters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  };

  List<Meal> get _availableMeals {
    return dummyMeals.where((meal) {
      if (_filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
  }

  void _showInfoMassage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _setScreen(String identifier) {
    if (identifier == 'Filters') {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _filters,
            saveFilters: (newFilters) {
              setState(() {
                _filters = newFilters;
              });
            },
          ),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeal.remove(meal);
      });
      _showInfoMassage('Meal is no longer in a favorite.');
    } else {
      setState(() {
        _favoriteMeal.add(meal);
        _showInfoMassage('Marked As A Favorite!');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToogleFavorite: _toggleMealFavoriteStatus,
      availableMeals: _availableMeals,
    );
    var activePageTitile = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeal,
        onToogleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitile = 'Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitile),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectdScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
        ],
      ),
    );
  }
}
