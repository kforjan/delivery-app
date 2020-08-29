import 'package:delivery_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_selection.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _showLogOffDialog(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: theme.canvasColor,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        color: Theme.of(context).primaryColor,
        child: OrderSelection.create(),
      ),
    );
  }

  void _showLogOffDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('All data will be lost if you log off.'),
        content: Text('Are you sure you want to continue?'),
        actions: [
          FlatButton(
            child: Text('YES'),
            onPressed: () async {
              Navigator.pop(context);
              await Provider.of<AuthBase>(context, listen: false).signOut();
            },
          ),
          FlatButton(
            child: Text('NO'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
