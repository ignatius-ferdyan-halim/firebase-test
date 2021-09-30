import 'package:firebase_test/services/auth.dart';
import 'package:flutter/material.dart';
import '/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Test Firebase'),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
