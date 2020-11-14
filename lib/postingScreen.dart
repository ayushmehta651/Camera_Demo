import 'dart:io';
import 'package:camera_demo/services/curd.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostingScreen extends StatefulWidget {
  PostingScreen({Key key}) : super(key: key);

  @override
  _PostingScreenState createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  CrudMethods crudMethods = new CrudMethods();

  File imageFile;
  String destination;
  String work;
  bool _isLoading = true;

  _permissionRequest(BuildContext context) async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Bubble',
    );
    var result = await permissionValidator.camera();
    if (result) {
      _showChoiceDialog();
    }
  }

  _openCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  _openGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              title: Text('Make a Choice!'),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _openGallery();
                    },
                    child: Text('Gallery'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openCamera();
                    },
                    child: Text('Camera'),
                  ),
                ],
              )));
        });
  }

  @override
  void initState() {
    super.initState();
    _permissionRequest(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bub",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "le",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    imageFile != null
                        ? GestureDetector(
                            onTap: () {
                              _showChoiceDialog();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black45,
                            ),
                          ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Where Are u heading to?"),
                            onChanged: (val) {
                              destination = val;
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: "How are u gonna enjoy?"),
                            onChanged: (val) {
                              work = val;
                            },
                          ),
                          RaisedButton(
                              color: Colors.blue,
                              child: Text("Uplaod"),
                              onPressed: () {})
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
