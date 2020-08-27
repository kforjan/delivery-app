import 'package:flutter/material.dart';

import 'order_selection.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 50,
          left: 20,
          right: 20,
        ),
        color: Theme.of(context).primaryColor,
        child: OrderSelection.create(),
      ),
    );
  }
}
