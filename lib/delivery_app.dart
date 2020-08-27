import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/landing_page/landing_page.dart';
import 'services/auth.dart';
import 'services/database.dart';
import 'theme.dart';

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (context) => Auth(),
        ),
        Provider<Database>(
          create: (context) => FirestoreDatabase(),
        )
      ],
      child: MaterialApp(
        theme: buildTheme(),
        title: 'DeliveyApp',
        home: Scaffold(
          body: Center(
            child: LandingPage(),
          ),
        ),
      ),
    );
  }
}
