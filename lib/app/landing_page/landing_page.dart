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
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.active) {
          User _user = userSnapshot.data;

          if (_user == null) {
            return SignInPage.create(context);
          } else {
            return StreamBuilder(
              stream: _databse.getUserTypeStream(_user.userId),
              builder: (context, typeSnapshot) {
                if (typeSnapshot.data == UserType.deliver) {
                  return DeliverPage();
                } else if (typeSnapshot.data == UserType.order) {
                  return OrderPage();
                } else {
                  return _buildLoadingScreen(context);
                }
              },
            );
          }
        } else {
          return _buildLoadingScreen(context);
        }
      },
    );
  }

  Widget _buildLoadingScreen(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: mediaQuery.size.height,
            color: theme.primaryColor,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(theme.accentColor),
                  ),
                  const SizedBox(height: 50),
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: theme.accentColor),
                    ),
                    onPressed: Provider.of<AuthBase>(context).signOut,
                  )
                ],
              ),
            ),
          ),
          Container(
            color: theme.accentColor,
            height: mediaQuery.size.height * 0.25,
          ),
        ],
      ),
    );
  }
}

enum SignInFormType {
  signIn,
  register,
}
