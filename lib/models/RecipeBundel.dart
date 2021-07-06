import 'package:flutter/material.dart';

class RecipeBundle {
  final int? id, chefs, recipes;
  final String? title, description, imageSrc;
  final Color? color;

  RecipeBundle(
      {this.id,
      this.chefs,
      this.recipes,
      this.title,
      this.description,
      this.imageSrc,
      this.color});
}

// Demo list
List<RecipeBundle> recipeBundles = [
  RecipeBundle(
    id: 1,
    chefs: 16,
    recipes: 95,
    title: "Tahu Bulat",
    description: "Digoreng Dadakan",
    imageSrc: "assets/images/cook_new@2x.png",
    color: Color(0xFFD82D40),
  ),
  RecipeBundle(
    id: 2,
    chefs: 8,
    recipes: 26,
    title: "Bakso Bulat",
    description: "Ada yang bulat tapi bukan tekat",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Color(0xFF90AF17),
  ),
  RecipeBundle(
    id: 3,
    chefs: 10,
    recipes: 43,
    title: "Masakan Padang ala Salatiga",
    description: "Masakan Padang Tapi bukan dari padang",
    imageSrc: "assets/images/food_court@2x.png",
    color: Color(0xFF2DBBD8),
  ),
];
