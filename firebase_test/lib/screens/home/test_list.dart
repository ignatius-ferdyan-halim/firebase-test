import 'package:firebase_test/models/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/test.dart';
import 'test_tile.dart';

class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  @override
  Widget build(BuildContext context) {
    final tests = Provider.of<List<Test>>(context) ?? [];

    return ListView.builder(
      itemCount: tests.length,
      itemBuilder: (context, index) {
        return TestTile(test: tests[index]);
      },
    );
  }
}
