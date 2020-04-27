import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List <Meal> favoriteMeal;
  FavouriteScreen(this.favoriteMeal);

  @override
  Widget build(BuildContext context) {
    if(favoriteMeal.isEmpty){ 
    return Center(
      child: Text("No favorites yet , Add some!"),
      
    );
    }
    else {
     return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeal[index].id,
            title: favoriteMeal[index].title,
            imageUrl: favoriteMeal[index].imageUrl,
            duration: favoriteMeal[index].duration,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
          );
        },
        itemCount: favoriteMeal.length,
      );

    }
  }
}