import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  final String text;
  bool isChecked;
  final Function callback;

  TaskItem(
      {Key? key,
      required this.text,
      this.isChecked = false,
      required this.callback})
      : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            widget.isChecked = !widget.isChecked;
            widget.callback();
          });
        },
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                  color: widget.isChecked
                      ? MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Color.fromRGBO(218, 218, 218, 1)
                          : Color.fromRGBO(14, 14, 17, 1)
                      : MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Color.fromRGBO(248, 248, 248, 1)
                          : Color.fromRGBO(43, 45, 55, 1),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Color.fromRGBO(218, 218, 218, 1)
                          : Color.fromRGBO(14, 14, 17, 1))),
              width: 24,
              height: 24,
              child: widget.isChecked
                  ? Icon(
                      Icons.check,
                      size: 20,
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    )
                  : null,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 18,
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Color.fromRGBO(87, 87, 103, 1)
                          : Color.fromRGBO(218, 218, 218, 1),
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
