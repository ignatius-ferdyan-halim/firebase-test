import 'package:firebase_test/screens/home/settings_forms.dart';
import 'package:flutter/material.dart';
import '/services/auth.dart';
import '/services/database.dart';
import 'package:provider/provider.dart';
import 'test_list.dart';
import '/models/test.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    //
    void _showSettings() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Test>>.value(
      initialData: [],
      value: DatabaseService().tests,
      child: Scaffold(
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
            ),
            TextButton.icon(
              onPressed: () => _showSettings(),
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/piano.png'), fit: BoxFit.cover)),
          child: TestList(),
        ),
      ),
    );
  }
}
