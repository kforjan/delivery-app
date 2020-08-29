import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deliver_button.dart';
import 'order_button.dart';
import 'sign_in_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({@required this.model});

  final SignInModel model;

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<SignInModel>(
      create: (context) => SignInModel(),
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
              model: model,
            ),
            OrderButton(
              model: model,
            ),
          ],
        ),
      ),
    );
  }
}
