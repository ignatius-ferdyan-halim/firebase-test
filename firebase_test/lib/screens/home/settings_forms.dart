import 'package:firebase_test/models/user.dart';
import 'package:firebase_test/services/database.dart';
import 'package:firebase_test/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugar;
  int _currentLevel;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your test settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugar ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugar = val),
                  ),
                  Slider(
                    value: (_currentLevel ?? userData.level).toDouble(),
                    activeColor: Colors.blue[_currentLevel ?? userData.level],
                    inactiveColor: Colors.blue[_currentLevel ?? userData.level],
                    min: 0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentLevel = val.round()),
                  ),
                  //slider
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugar ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentLevel ?? userData.level,
                        );
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.blue[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      await DatabaseService(uid: user.uid).deleteUserData(
                        _currentSugar ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentLevel ?? userData.level,
                      );
                      Navigator.pop(context);
                    },
                    color: Colors.blue[400],
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
