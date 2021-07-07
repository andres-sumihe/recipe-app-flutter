import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/network/service/user_service.dart';
import 'package:recipe_app/provider/user/UserDataProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_app/screens/profile/components/info.dart';
import 'package:recipe_app/screens/profile/components/profile_menu_item.dart';
import 'package:recipe_app/size_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  String? imgUrl;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    _imageFile = File(pickedFile!.path);
    if (_imageFile != null) {
      uploadImageToFirebase(context);
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = Path.basename(_imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    uploadTask.whenComplete(() {
      firebaseStorageRef.getDownloadURL().then((String value) async {
        print("IMAGE URL: " + value);
        bool updateSuccess = await UserService.updateUserPicture(value);
        if (updateSuccess) {
          print("SUCCESSS");
          Fluttertoast.showToast(
              msg: "Image Was Uploaded",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black.withOpacity(.8),
              textColor: Colors.white,
              fontSize: 16.0);
          
        }
      });
    }).catchError((onError) {
      print(onError);
    });
    return Path.url;
  }

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
                image: provider.getData?.pictureUrl,
                name: provider.getData?.name,
                email: provider.getData?.email,
                openCam: () {
                  print("TEST");
                  pickImage();
                },
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
