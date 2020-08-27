import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth.dart';

class DeliverPage extends StatelessWidget {
  const DeliverPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(100),
        child: FlatButton(
          child: Text('WIP'),
          onPressed: () async {
            Provider.of<AuthBase>(context, listen: false).signOut();
          },
        ),
      ),
    );
  }
}
