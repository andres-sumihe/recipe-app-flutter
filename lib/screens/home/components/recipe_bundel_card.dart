import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/models/Recipe.dart';
import 'dart:math';
import '../../../size_config.dart';

class RecipeCard extends StatelessWidget {
  final Recipe? recipe;
  final Function? press;

  const RecipeCard({Key? key, this.recipe, this.press}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    List colors = [Color(0xFFD82D40), Color(0xFF90AF17), Color(0xFF2DBBD8)];
    double defaultSize = SizeConfig.defaultSize!;
    // Now we dont this Aspect ratio
    return GestureDetector(
      onTap: press!(),
      child: Container(
        decoration: BoxDecoration(
          color: colors[random.nextInt(3)],
          borderRadius: BorderRadius.circular(defaultSize * 1.8), //18
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultSize * 2), //20
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      recipe!.recipeName,
                      style: TextStyle(
                          fontSize: defaultSize * 2.2, //22
                          color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: defaultSize * 0.5), // 5
                    Text(
                      recipe!.description,
                      style: TextStyle(color: Colors.white54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    buildInfoRow(
                      defaultSize,
                      iconSrc: "assets/icons/pot.svg",
                      text: "1 Ingredients",
                    ),
                    SizedBox(height: defaultSize * 0.5), //5
                    buildInfoRow(
                      defaultSize,
                      iconSrc: "assets/icons/chef.svg",
                      text: "1 Steps",
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(width: defaultSize * 0.5), //5
            AspectRatio(
              aspectRatio: 0.71,
              child: Image.asset(
                recipe!.recipePictureUrl,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildInfoRow(double defaultSize, {String? iconSrc, text}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(iconSrc!),
        SizedBox(width: defaultSize), // 10
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
