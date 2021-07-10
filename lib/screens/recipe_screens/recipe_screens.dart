import 'dart:io';

import 'package:collapsible/collapsible.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/Recipe.dart';
import 'package:recipe_app/provider/recipe/cooking_steps_provider.dart';
import 'package:recipe_app/provider/recipe/groceries_provider.dart';
import 'package:select_form_field/select_form_field.dart';
import '../../size_config.dart';

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class RecipeScreen extends StatelessWidget {
  final Recipe? recipe;

  RecipeScreen({@required this.recipe});
  File? _imageFile;
  String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.getProportionateScreenWidth(360),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [orange, yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: SizeConfig.getProportionateScreenWidth(240),
                        height: SizeConfig.getProportionateScreenWidth(240),
                        child: Image.asset(
                          recipe!.recipePictureUrl,
                          width: SizeConfig.getProportionateScreenWidth(260),
                          height: SizeConfig.getProportionateScreenWidth(260),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        recipe!.recipeName,
                        style: TextStyle(
                            fontSize: SizeConfig.defaultSize! * 2.2, //22
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize! * 2.2, //22
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            recipe!.description,
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize! * 2, //22
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Groceries',
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize! * 2.2, //22
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Consumer<GroceriesProvider>(
                            builder: (context, value, child) {
                              value.load(recipe!.recipeId);
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                itemCount: value.groceryData!.length,
                                itemBuilder: (context, index) {
                                  final item = value.groceryData![index];
                                  return ListTile(
                                    minVerticalPadding: 0,
                                    title: Text(item.groceriesName),
                                    trailing: Text(item.groceriesQuantity),
                                  );
                                },
                              );
                            },
                          ),
                          Text(
                            'Cooking Steps',
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize! * 2.2, //22
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Consumer<CookingStepProvider>(
                            builder: (context, value, child) {
                              value.load(recipe!.recipeId);
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                itemCount: value.cookingStepsData!.length,
                                itemBuilder: (context, index) {
                                  final item = value.cookingStepsData![index];
                                  return ListTile(
                                    minVerticalPadding: 0,
                                    title: Text(item.title),
                                    subtitle: Text(item.description),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
