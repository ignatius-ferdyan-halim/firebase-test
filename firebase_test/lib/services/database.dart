import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/user.dart';
import '/models/test.dart';

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

  //test delete
  Future deleteUserData(String sugars, String name, int level) async {
    return await testCollection.document(uid).setData({
      'sugars': '0',
      'name': name,
      'level': 0,
    });
  }

  //test list from snapshot
  List<Test> _testListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Test(
        name: doc.data['name'] ?? '',
        level: doc.data['level'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      level: snapshot.data['level'],
    );
  }

  //get test stream
  Stream<List<Test>> get tests {
    return testCollection.snapshots().map(_testListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return testCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
