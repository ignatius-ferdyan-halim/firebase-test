import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference testCollection =
      Firestore.instance.collection('test');

  Future updateUserData(String sugars, String name, int level) async {
    return await testCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'level': level,
    });
  }
}
