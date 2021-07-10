import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/provider/auth/login_provider.dart';
import 'package:recipe_app/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Gender { male, female }

class SignUpScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController gender = new TextEditingController();

  Gender _gender = Gender.male;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   Provider.of<LoginProvider>(context, listen: false)
    //       .login(email.text, password.text);
    // });
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: kTextColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: kTextLigntColor,
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(color: kTextColor, fontFamily: 'OpenSans'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: password,
            obscureText: true,
            style: TextStyle(
              color: kTextColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: kTextLigntColor,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(color: kTextColor, fontFamily: 'OpenSans'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: username,
            obscureText: true,
            style: TextStyle(
              color: kTextColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: kTextLigntColor,
              ),
              hintText: 'Enter your Username',
              hintStyle: TextStyle(color: kTextColor, fontFamily: 'OpenSans'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: username,
            obscureText: true,
            style: TextStyle(
              color: kTextColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: kTextLigntColor,
              ),
              hintText: 'Enter your Name',
              hintStyle: TextStyle(color: kTextColor, fontFamily: 'OpenSans'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Choose Your Gender',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: Column(
            children: [
              ListTile(
                title: const Text('Male'),
                leading: Radio<Gender>(
                  activeColor: Colors.white,
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Female'),
                leading: Radio<Gender>(
                  activeColor: Colors.white,
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) => Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => {
            provider.login(email.text, password.text),
            if (provider.loginSuccess)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                )
              }
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            'SIGN UP',
            style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AE35),
                      Color(0xFF61A431),
                      Color(0xFF478D30),
                      Color(0xFF398A35),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildNameTF(),
                      SizedBox(height: 20.0),
                      _buildEmailTF(),
                      SizedBox(height: 20.0),
                      _buildPasswordTF(),
                      SizedBox(height: 20.0),
                      _buildUsernameTF(),
                      SizedBox(height: 20.0),
                      _buildGenderTF(),
                      _buildSignUpBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
