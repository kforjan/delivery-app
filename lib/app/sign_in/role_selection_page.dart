import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deliver_button.dart';
import 'order_button.dart';
import 'role_selection_model.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({@required this.model});

  final RoleSelectionModel model;

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<RoleSelectionModel>(
      create: (context) => RoleSelectionModel(),
      child: Consumer<RoleSelectionModel>(
        builder: (context, model, _) => RoleSelectionPage(
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
