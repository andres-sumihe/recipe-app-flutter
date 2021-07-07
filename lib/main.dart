import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cron/cron.dart';
import 'package:recipe_app/models/NavItem.dart';
import 'package:recipe_app/provider/auth/login_provider.dart';
import 'package:recipe_app/provider/user/UserDataProvider.dart';
import 'package:recipe_app/provider/recipe/recipe_provider.dart';
import 'package:recipe_app/screens/signin/signin_screen.dart';

void main() async {
  final cron = Cron();

  // cron.schedule(Schedule.parse('*/10 * * * *'), () async {
  //   print('Backup Started');
  //   if(await AutobackupService.backup()){
  //     print("Backup Successfully");
  //   }
  // });

  cron.close();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => NavItems()),
                ChangeNotifierProvider(create: (_) => LoginProvider()),
                ChangeNotifierProvider(create: (_) => UserDataProvider()),
                ChangeNotifierProvider(create: (_) => RecipeProvider()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Recipe App',
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: SignInScreen(),
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: CircularProgressIndicator());
        });
  }
}
