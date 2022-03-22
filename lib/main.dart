import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_list/task_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FutureBuilder<List>(future: getPrefs(),builder: (context, snapshot) {
    if (snapshot.hasData) {
      var nameTitle = snapshot.data![0];
      var checklist = snapshot.data![1];
      return Tasklist(nameTitle, checklist);
    } else {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }));
}

Future<List> getPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> name = prefs.getStringList('name') ?? [];
  final List<String> check = prefs.getStringList('check') ?? [];
  List<bool?> _check = check.map((e) => e == 'true').toList();
  return [name, _check];
}

void setPrefs(List<String> name, List<bool?> check) async {
  List<String> _check = check.map((e) => e.toString()).toList();
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('check', _check);
  prefs.setStringList('name', name);
}
