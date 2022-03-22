import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  final String text;
  bool isChecked;
  final Function callback;


   TaskItem({Key? key, required this.text, this.isChecked = false, required this.callback})
      : super(key: key);
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Color.fromRGBO(218, 218, 218, 1);
    }
    return Color.fromRGBO(218, 218, 218, 1);
  }

  @override
  State<TaskItem> createState() => _TaskItemState();
}


class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(widget.getColor),
            value: widget.isChecked,
            onChanged: (bool? value) {
              widget.callback();
            },
          ),
          Text(widget.text, style: TextStyle(fontSize: 18, color: Color.fromRGBO(87, 87, 103, 1), fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}