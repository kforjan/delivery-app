import 'package:delivery_app/app/sign_in/deliver_button.dart';
import 'package:delivery_app/app/sign_in/order_button.dart';
import 'package:delivery_app/app/sign_in/sign_in_model.dart';
import 'package:delivery_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({@required this.model});

  final SignInModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<SignInModel>(
      create: (context) => SignInModel(auth: auth),
      child: Consumer<SignInModel>(
        builder: (context, model, _) => SignInPage(
          model: model,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            DeliverButton(
              onTap: model.registerDeliver,
            ),
            OrderButton(
              onTap: model.registerOrder,
            ),
          ],
        ),
      ),
    );
  }
}
