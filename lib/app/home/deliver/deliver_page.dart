import 'package:delivery_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'orders_list.dart';

class DeliverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.accentColor,
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
        color: Theme.of(context).accentColor,
        child: OrdersList.create(),
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
            onPressed: () {
              Navigator.pop(context);
              Provider.of<AuthBase>(context, listen: false).signOut();
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
