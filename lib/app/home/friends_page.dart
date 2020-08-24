import 'package:delivery_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(100),
        child: FlatButton(
          child: Text('text'),
          onPressed: () =>
              Provider.of<AuthBase>(context, listen: false).signOut(),
        ),
      ),
    );
  }
}
