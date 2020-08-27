import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../services/database.dart';
import '../home/deliver/deliver_page.dart';
import '../home/order/order_page.dart';
import '../sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthBase>(context, listen: false);
    final _databse = Provider.of<Database>(context, listen: false);
    return StreamBuilder(
      stream: _auth.onAuthChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User _user = snapshot.data;

          if (_user == null) {
            return SignInPage.create(context);
          }
          if (_user != null)
            return StreamBuilder(
              stream: _databse.getUserTypeStream(_user.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  print(snapshot.data);
                  if (snapshot.data == UserType.deliver) {
                    return DeliverPage();
                  } else if (snapshot.data == UserType.order) {
                    return OrderPage();
                  } else {
                    return LoadingScreen();
                  }
                } else {
                  return LoadingScreen();
                }
              },
            );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
