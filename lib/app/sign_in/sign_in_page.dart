import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import 'deliver_button.dart';
import 'order_button.dart';
import 'sign_in_model.dart';

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
