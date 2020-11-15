import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addPost(postData) async {
    FirebaseFirestore.instance
        .collection("postImage")
        .add(postData)
        .catchError((e) {
      print(e);
    });
  }

  getPost() async {
    return await FirebaseFirestore.instance.collection("blogs").snapshots();
  }
}
