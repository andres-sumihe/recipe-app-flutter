import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/recipe_screens/add_recipe_screen.dart';
import 'package:recipe_app/screens/home/components/body.dart';
import 'package:recipe_app/screens/profile/prrofile_screen.dart';
import 'package:recipe_app/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavBottomBarIndex = 0;

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _currentNavBottomBarIndex = value;
          });
        },
        children: [
          Body(),
          // Center(),
          AddRecipeScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: blackPrimary.withOpacity(0.09),
              offset: Offset(0, 4),
              blurRadius: 25,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavBottomBarIndex,
          backgroundColor: Colors.white,
          elevation: 0,
          showUnselectedLabels: true,
          fixedColor: Colors.black,
          unselectedItemColor: blackPrimary,
          selectedLabelStyle: regularBaseFont.copyWith(
            fontSize: 11,
            color: Colors.black,
          ),
          unselectedLabelStyle: regularBaseFont.copyWith(
            fontSize: 11,
            color: blackPrimary,
          ),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: 'Beranda',
              backgroundColor: Colors.white,
              icon: SvgPicture.asset(
                'assets/icons/chef_nav.svg',
                color: _currentNavBottomBarIndex == 0
                    ? kPrimaryColor
                    : Color(0xFFD1D4D4),
                height: 22,
              ),
            ),
            // BottomNavigationBarItem(
            //   label: 'Trending',
            //   backgroundColor: Colors.white,
            //   icon: SvgPicture.asset(
            //     'assets/icons/hot.svg',
            //     color: _currentNavBottomBarIndex == 1
            //         ? kPrimaryColor
            //         : Color(0xFFD1D4D4),
            //     height: 22,
            //   ),
            // ),
            BottomNavigationBarItem(
              label: 'Buat',
              backgroundColor: Colors.white,
              icon: SvgPicture.asset(
                'assets/icons/camera.svg',
                color: _currentNavBottomBarIndex == 1
                    ? kPrimaryColor
                    : Color(0xFFD1D4D4),
                height: 22,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              backgroundColor: Colors.white,
              icon: SvgPicture.asset(
                'assets/icons/user.svg',
                color: _currentNavBottomBarIndex == 2
                    ? kPrimaryColor
                    : Color(0xFFD1D4D4),
                height: 22,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentNavBottomBarIndex = index;
            });

            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Image.asset("assets/images/logo.png"),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        SizedBox(
          width: SizeConfig.defaultSize! * 0.5,
        )
      ],
    );
  }
}
