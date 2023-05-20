import 'package:big_data_front_end/UI/contents/Statistiche_prodotti.dart';
import 'package:big_data_front_end/UI/contents/dashboard_content.dart';
import 'package:big_data_front_end/UI/contents/prodotti_comprati_assieme.dart';
import 'package:big_data_front_end/UI/contents/prodotti_dipartimento.dart';
import 'package:big_data_front_end/UI/contents/regole_associazione.dart';
import 'package:big_data_front_end/UI/contents/top_prodotti_content.dart';
import 'package:big_data_front_end/UI/screens/Screen.dart';
import 'package:flutter/material.dart';

import '../../model/support/constants.dart';
import 'drawer_list_tile.dart';
import 'numero_oggetti_ordine.dart';


class DrawerMenu extends StatefulWidget {

  final Function notifyParent;

  DrawerMenu(this.notifyParent);

  @override
  DrawerMenuState createState() => DrawerMenuState();
}
class DrawerMenuState extends State<DrawerMenu>{

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/logoGrocery.png"),
          ),
          DrawerListTile(
              title: 'WELCOME',
              svgSrc: 'assets/icons/Dashboard.svg',
              tap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen(page: DashboardContent()))
                );
              }),
          DrawerListTile(
              title: 'Prodotti più acquistati',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen(page: TopProdottiContent()))
                );
              }),
          DrawerListTile(
              title: 'Statistiche sugli acquisti',
              svgSrc: 'assets/icons/Message.svg',
              tap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen(page: StatisticheProdotti()))
                );
              }),
          DrawerListTile(
              title: 'Numero oggetti in ordine',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>Screen(page: NumeroOggettiInOrdine()))
                );
              }),
          DrawerListTile(
              title: 'Prodotti venduti per dipartimento',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>Screen(page: ProdottiVendutiDipartimento()))
                );
              }),

          DrawerListTile(
              title: 'Associazioni prodotti',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>Screen(page: RegoleAssociazione()))
                );
              }),
          DrawerListTile(
              title: 'Comprati Insieme',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>Screen(page: ProdottiCompratiAssieme()))
                );
              }),
        ],
      ),
    );
  }

}
