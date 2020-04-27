import 'package:flutter/material.dart';

import './models/meal.dart';

import './dummy_data.dart';
import './screen/filters_screen.dart';
import './screen/meal_detail_screen.dart';
import './screen/category_recipe_screen.dart';
import './screen/categories_screen.dart';
import './screen/tab_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

List<Meal> _availableMeals = DUMMY_MEALS;
List<Meal> _favoriteMeals = [];

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };

  void _setFilters(Map<String, bool> newFilters) {
    setState(() {
      _filters = newFilters;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          print("gluten");
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          print("gluten");
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          print("vegatarian");
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          print("gluten");
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) {
      return meal.id == mealId;
    });

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  bool isFavorite(String mealId){
    return _favoriteMeals.any((meal)=> meal.id==mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeal',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 232, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontFamily: "RobotoCondensed",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeals,),
        CategoryRecipeScreen.route: (ctx) =>
            CategoryRecipeScreen(_availableMeals),
        MealDetailScreen.route: (ctx) => MealDetailScreen(toggleFavorite,isFavorite),
        FiltersScreen.route: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
