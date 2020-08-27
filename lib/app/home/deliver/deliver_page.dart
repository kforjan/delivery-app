import 'package:flutter/material.dart';

import 'orders_list.dart';

class DeliverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 30,
        ),
        color: Theme.of(context).accentColor,
        child: OrdersList.create(),
      ),
    );
  }
}
