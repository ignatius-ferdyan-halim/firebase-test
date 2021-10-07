import 'package:flutter/material.dart';
import 'package:firebase_test/models/test.dart';

class TestTile extends StatelessWidget {
  final Test test;

  TestTile({this.test});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue[test.level],
            backgroundImage: AssetImage('assets/blue-circle-2.png'),
          ),
          title: Text(test.name),
          subtitle: Text('Takes ${test.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
