import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_list/main.dart';
import 'package:task_list/taks_item.dart';

class Tasklist extends StatefulWidget {
  final nameTitle;
  final checklist;

  const Tasklist(this.nameTitle, this.checklist, {Key? key, isChecked, text})
      : super(key: key);

  @override
  State<Tasklist> createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  var nameTitle = <String>[];
  var checklist = <bool?>[];

  @override
  void initState() {
      nameTitle.addAll(widget.nameTitle);
      checklist.addAll(widget.checklist);

  }

  void Function() change(int ind) {
    return () => setState(() {
          checklist[ind] = !checklist[ind]!;
          setPrefs(nameTitle, checklist);
        });
  }

  @override
  Widget build(BuildContext context) {
    log('$checklist');
    return MaterialApp(
      title: 'TaskList',
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          body: Padding(
            padding: const EdgeInsets.only(top: 64, left: 64, right: 64),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tasks',
                        style: TextStyle(
                            fontSize: 56,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                    GestureDetector(
                      onTap: checklist.contains(null) ? null : (){
                        setState(() {
                          nameTitle.insert(0, '');
                          checklist.insert(0, null);
                        });
                      },
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromRGBO(242, 243, 255, 1),
                            border: Border.all(
                                width: 1.0,
                                color: const Color.fromRGBO(235, 235, 235, 1))),
                        child: Icon(
                          Icons.add,
                          color: Color.fromRGBO(87, 87, 103, 1),
                          size: 32,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Container(
                      height: 1, color: Color.fromRGBO(235, 235, 235, 1)),
                ),
                Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: List.generate(nameTitle.length, (index) {
                        if (checklist[index] == null) {
                          return TextField(
                            autofocus: true,
                            onSubmitted: (text) {
                              setState(() {
                                nameTitle[0] = text;
                                checklist[0] = false;
                                setPrefs(nameTitle, checklist);
                              });
                            },
                          );
                        }
                        return TaskItem(
                          text: nameTitle[index],
                          isChecked: checklist[index] ?? false,
                          callback: change(index),
                        );
                      })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
