import 'package:delivery_app/services/auth.dart';
import 'package:delivery_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliverPage extends StatelessWidget {
  const DeliverPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(100),
        child: FlatButton(
          child: Text('DELIVERRR'),
          onPressed: () async {
            Provider.of<AuthBase>(context, listen: false).signOut();
          },
        ),
      ),
    );
  }
}
