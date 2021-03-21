import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

import '../models/meal.model.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen({
  //   @required this.categoryId,
  //   @required this.categoryTitle
  // });

  final List<Meal> availableMeals;

  CategoryMealsScreen(
    this.availableMeals
  );

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;
  
  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = 
      ModalRoute.of(context).settings.arguments 
      as Map<String, String>;

      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];

      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
     _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => mealId == meal.id);
    });
  }
 
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle)
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title:displayedMeals[index].title,
              imageUrl:displayedMeals[index].imageUrl,
              affordability:displayedMeals[index].affordability,
              duration:displayedMeals[index].duration,
              complexity:displayedMeals[index].complexity,
              id:displayedMeals[index].id,
              removeItem: _removeMeal
            );
          },
          itemCount: displayedMeals.length
        )
      )
    );
  }
}