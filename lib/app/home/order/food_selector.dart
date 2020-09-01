import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class FoodSelector extends StatefulWidget {
  FoodSelector({
    @required this.changeHandler,
    @required this.imagePath,
  });

  final Function changeHandler;
  final String imagePath;

  @override
  _FoodSelectorState createState() => _FoodSelectorState();
}

class _FoodSelectorState extends State<FoodSelector> {
  int _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Container(
            height: mediaQuery.size.width * 0.27,
            width: mediaQuery.size.width * 0.27,
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.fill,
            ),
          ),
        ),
        NumberPicker.integer(
          infiniteLoop: true,
          listViewWidth: mediaQuery.size.width * 0.15,
          initialValue: _currentValue,
          minValue: 0,
          maxValue: 10,
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
