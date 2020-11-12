import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostImage extends StatefulWidget {
  PostImage({Key key}) : super(key: key);

  @override
  _PostImageState createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  File imageFile;
  _openGallery(BuildContext context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  _openCamera(BuildContext context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
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
                      _openGallery(context);
                    },
                    child: Text('Gallery'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openCamera(context);
                    },
                    child: Text('Camera'),
                  ),
                ],
              )));
        });
  }

  Widget _imageNotNull() {
    if (imageFile == null) {
      return Text('Oops , No image Selected!!');
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          _imageNotNull(),
          Padding(
            padding:
                const EdgeInsets.only(top: 200, left: 240, right: 2, bottom: 2),
            child: FloatingActionButton(
              elevation: 10.0,
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
              onPressed: () {
                _showChoiceDialog(context);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
