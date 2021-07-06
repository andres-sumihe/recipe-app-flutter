import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/provider/user/UserDataProvider.dart';
import 'package:recipe_app/screens/profile/components/body.dart';
import 'package:recipe_app/screens/profile/components/info.dart';
import 'package:recipe_app/screens/profile/components/profile_menu_item.dart';
import 'package:recipe_app/size_config.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<UserDataProvider>(context, listen: false).getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Consumer<UserDataProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Info(
                image: "assets/images/pic.png",
                name: provider.getData?.name,
                email: provider.getData?.email,
              ),
              SizedBox(height: SizeConfig.defaultSize! * 2), //20
              ProfileMenuItem(
                iconSrc: "assets/icons/bookmark_fill.svg",
                title: "Resep Tersimpan",
                press: () {},
              ),
              ProfileMenuItem(
                iconSrc: "assets/icons/chef_color.svg",
                title: "Resep Saya",
                press: () {},
              ),
              ProfileMenuItem(
                iconSrc: "assets/icons/language.svg",
                title: "Ganti Bahasa",
                press: () {},
              ),
              ProfileMenuItem(
                iconSrc: "assets/icons/info.svg",
                title: "Bantuan",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: SizedBox(),
      // On Android it's false by default
      centerTitle: true,
      title: Text("Profile"),
      actions: <Widget>[
        TextButton(
          onPressed: () {},
          child: Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.defaultSize! * 1.6, //16
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
