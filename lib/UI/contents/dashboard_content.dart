import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/support/constants.dart';
import '../../model/support/responsive.dart';
import 'grafico_colonne.dart';


class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children:[
          Expanded(
            child: Text(
            "Benvenuti nell'applicazione \n per l'analisi del carrello della spesa",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Image.asset("assets/images/fotoWelcome1.png"),
          )
        ]
      ),
    );
  }
}
