import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../services/database.dart';

class OrderButton extends StatelessWidget {
  final Function onTap;

  const OrderButton({
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
            .addUserType(user.userId, UserType.order);
      },
      child: Container(
        color: Color.fromRGBO(234, 84, 85, 1),
        height: mediaQuery.size.height * 0.75,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.restaurant,
                size: 50,
                color: Color.fromRGBO(229, 229, 229, 1),
              ),
              SizedBox(height: 20),
              Text(
                'I am here to order food.',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(229, 229, 229, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
