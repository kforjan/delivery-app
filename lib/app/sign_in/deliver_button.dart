import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../services/database.dart';

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
        color: Color.fromRGBO(45, 64, 89, 1),
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
                      color: Color.fromRGBO(229, 229, 229, 1),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'I am here to deliver orders.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(229, 229, 229, 1),
                      ),
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
