import 'package:flutter/material.dart';
import '../models/meal.dart';

import './favourite_screen.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabScreen(this.favoriteMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> screens;
  var _selectedIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    screens = [
      {"widget": CategoriesScreen(), "title": "Categories"},
      {"widget": FavouriteScreen(widget.favoriteMeals), "title": "Favourites"},
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screens[_selectedIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: screens[_selectedIndex]['widget'],
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).accentColor,
          currentIndex: _selectedIndex,
          onTap: _selectScreen,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.toll), title: Text('Favorite meals')),
            BottomNavigationBarItem(
                icon: Icon(Icons.toll), title: Text("Categories")),
          ]),
    );
  }
}
