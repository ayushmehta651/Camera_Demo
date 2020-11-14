import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addPost(postData) async {
    FirebaseFirestore.instance.collection("post").add(postData).catchError((e) {
      print(e);
    });
  }
}
