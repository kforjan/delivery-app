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
            print(_user.userId);
            return StreamBuilder(
              stream: _databse.getUserTypeStream(_user.userId),
              builder: (context, typeSnapshot) {
                print(typeSnapshot.data.toString() + '2');
                if (typeSnapshot.connectionState == ConnectionState.active &&
                    typeSnapshot.data != null) {
                  print(typeSnapshot.data.toString() + '1');
                  if (typeSnapshot.data == UserType.deliver) {
                    return DeliverPage();
                  } else if (typeSnapshot.data == UserType.order) {
                    return OrderPage();
                  } else {
                    return _buildLoadingScreen(context, '1');
                  }
                } else {
                  return _buildLoadingScreen(context, '2');
                }
              },
            );
          }
        } else {
          return _buildLoadingScreen(context, '3');
        }
      },
    );
  }

  Widget _buildLoadingScreen(BuildContext context, String string) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 50),
            FlatButton(
              child: Text('Cancel' + string),
              onPressed: Provider.of<AuthBase>(context).signOut,
            )
          ],
        ),
      ),
    );
  }
}

enum SignInFormType {
  signIn,
  register,
}
