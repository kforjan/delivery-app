import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class FoodSelection extends StatefulWidget {
  final Function changeHandler;

  FoodSelection({this.changeHandler});

  @override
  _FoodSelectionState createState() => _FoodSelectionState();
}

class _FoodSelectionState extends State<FoodSelection> {
  int _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          child: Container(
            height: mediaQuery.size.width * 0.25,
            width: mediaQuery.size.width * 0.25,
            color: Color.fromRGBO(229, 229, 229, 1),
          ),
        ),
        NumberPicker.integer(
          infiniteLoop: true,
          listViewWidth: mediaQuery.size.width * 0.15,
          initialValue: _currentValue,
          minValue: 0,
          maxValue: 15,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
              widget.changeHandler(value);
            });
          },
        ),
      ],
    );
  }
}
