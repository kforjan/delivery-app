import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/services/auth.dart';
import 'package:delivery_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliverButton extends StatelessWidget {
  final Function onTap;

  const DeliverButton({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () async {
        await onTap();
        final user =
            await Provider.of<AuthBase>(context, listen: false).currentUser;
        Provider.of<Database>(context, listen: false)
            .addUserType(user.userId, UserType.deliver);
      },
      child: Container(
        color: Colors.purple,
        height: mediaQuery.size.height,
        child: Column(
          children: [
            SizedBox(
              height: mediaQuery.size.height * 0.75,
            ),
            Container(
              height: mediaQuery.size.height * 0.2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.drive_eta,
                      size: 50,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'I am here to deliver orders.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
