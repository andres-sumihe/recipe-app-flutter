import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/Recipe.dart';
import 'package:recipe_app/size_config.dart';
import 'package:recipe_app/provider/recipe/recipe_provider.dart';

import 'categories.dart';
import 'recipe_bundel_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<RecipeProvider>(context, listen: false).load();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Categories(),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 2),
              child: Consumer<RecipeProvider>(
                builder: (context, provider, child) {
                  List<Recipe>? recipes = provider.getAllRecipe;

                  if (recipes != null) {
                    return GridView.builder(
                      itemCount: recipes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            SizeConfig.orientation == Orientation.landscape
                                ? 2
                                : 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing:
                            SizeConfig.orientation == Orientation.landscape
                                ? SizeConfig.defaultSize! * 2
                                : 0,
                        childAspectRatio: 1.65,
                      ),
                      itemBuilder: (context, index) => RecipeCard(
                        recipe: recipes[index],
                        press: () {},
                      ),
                    );
                  }

                  return Center(child: Text('Tidak Ada Data'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
