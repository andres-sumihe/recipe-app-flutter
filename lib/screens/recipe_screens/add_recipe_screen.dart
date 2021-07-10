import 'dart:io';

import 'package:collapsible/collapsible.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:recipe_app/constants.dart';
import 'package:select_form_field/select_form_field.dart';
import '../../size_config.dart';

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class AddRecipeScreen extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState extends State<AddRecipeScreen> {
  File? _imageFile;
  String? imgUrl;
  int _currentPage = 0;
  bool _collapsed = false;

  void _toggleCollapsible() {
    _collapsed = !_collapsed;
    setState(() {});
  }

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    uploadTask.whenComplete(() {
      firebaseStorageRef.getDownloadURL().then((String value) => setState(() {
            imgUrl = value;
          }));
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentPage) {
      case 0:
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0)),
                    gradient: LinearGradient(
                        colors: [orange, yellow],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
              ),
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: SizeConfig.getProportionateScreenWidth(260),
                          height: SizeConfig.getProportionateScreenWidth(260),
                          child: _imageFile != null
                              ? Image.file(
                                  _imageFile!,
                                  width: SizeConfig.getProportionateScreenWidth(
                                      260),
                                  height:
                                      SizeConfig.getProportionateScreenWidth(
                                          260),
                                )
                              : TextButton(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                  ),
                                  onPressed: pickImage,
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
                          'Tambahkan Gambar Makanan',
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize! * 2.2, //22
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          child: Column(
                            children: [
                              SelectFormField(
                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                initialValue: '1',
                                labelText: 'Pilih Kategory',
                                items: categoryList,
                                onChanged: (val) => print(val),
                                onSaved: (val) => print(val),
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Nama Resep'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Nama Resep';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Deskripsi Resep'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Deskripsi Resep (max 250 karakter)';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _currentPage = 1;
                                  });
                                },
                                child: Text('Selanjutnya'),
                                style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 1:
        return Scaffold(
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {_currentPage = 0;});
                              },
                              child: Icon(Icons.arrow_left_sharp)),
                          Text(
                            'Bahan-bahan Resep',
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize! * 2.2, //22
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _currentPage = 2;
                                });
                              },
                              child: Icon(Icons.arrow_right_sharp)),
                        ],
                      ),
                    ),
                    Collapsible(
                      alignment: Alignment.topCenter,
                      collapsed: _collapsed,
                      axis: CollapsibleAxis.vertical,
                      child: Container(
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Nama Bahan'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Nama Bahan';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Banyak Bahan (Contoh: 1 KG)'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Banyak Bahan (Cth : Kg/ml)';
                                  }
                                  return null;
                                },
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: kPrimaryColor,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Tambahkan ',
                                    style: TextStyle(color: kPrimaryColor),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _toggleCollapsible(),
                      child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: _collapsed ? kPrimaryColor : Colors.red,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Center(
                            child: Text(
                              _collapsed ? 'Tambahkan Bahan' : 'Batalakan',
                              style: TextStyle(
                                  color:
                                      _collapsed ? kPrimaryColor : Colors.red),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      // ! Cooking Steps
      case 2:
        return Scaffold(
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {_currentPage = 1;});
                              },
                              child: Icon(Icons.arrow_left_sharp)),
                          Text(
                            'Tahapan Pembuatan',
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize! * 2.2, //22
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {_currentPage = 1;});
                              },
                              child: Icon(Icons.done_outline_outlined)),
                        ],
                      ),
                    ),
                    Collapsible(
                      alignment: Alignment.topCenter,
                      collapsed: _collapsed,
                      axis: CollapsibleAxis.vertical,
                      child: Container(
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Nama Tahapan'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Nama Tahapan';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Deskripsi Tahapan'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Deskripsi Tahapan';
                                  }
                                  return null;
                                },
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: kPrimaryColor,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Tambahkan ',
                                    style: TextStyle(color: kPrimaryColor),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _toggleCollapsible(),
                      child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: _collapsed ? kPrimaryColor : Colors.red,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Center(
                            child: Text(
                              _collapsed ? 'Tambahkan Tahapan' : 'Batalakan',
                              style: TextStyle(
                                  color:
                                      _collapsed ? kPrimaryColor : Colors.red),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      default:
        Center(
          child: CircularProgressIndicator(),
        );
    }
    return Container();
  }
}
