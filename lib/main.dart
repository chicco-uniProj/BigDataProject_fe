import 'package:big_data_front_end/UI/screens/Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/contents/dashboard_content.dart';
import 'model/support/controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progetto BigData grocery store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Controller(),)
        ],
        child: Screen(page:DashboardContent()),
      ),

    );
  }
}
