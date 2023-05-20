
import 'dart:convert';

import 'package:big_data_front_end/UI/contents/regole_associazione.dart';

import '../../UI/contents/Statistiche_prodotti.dart';
import '../../UI/contents/numero_oggetti_ordine.dart';
import '../../UI/contents/predizioni.dart';
import '../../UI/contents/prodotti_comprati_assieme.dart';
import '../../UI/contents/prodotti_dipartimento.dart';
import '../../UI/contents/top_prodotti_content.dart';
import 'constants.dart';
import 'package:http/http.dart';

class Model{

  static Model sharedInstance = Model();


  Future<List<String>?>department()async{
    try{
      final uri = Uri.http(ADDRESS_STORE_SERVER,REQUEST_DEPARTMENT,null);
      var response = await get(uri);
      print(response.body);
      return List<String>.from(json.decode(response.body));
      }
      catch(e){
      print(e.toString());
    }
  }

  Future <List<String>?>topProdotti(int numProd) async {
    Map<String,String> params = Map();
    params["numProd"] = numProd.toString();
    final uri = Uri.http(ADDRESS_STORE_SERVER,REQUEST_TOP_PRODUCTS,params);
    print(uri.toString());
    try{
      var response = await get(uri);
      //print(response.body);
      return List<String>.from(json.decode(response.body));
    }catch(e){
      print(e.toString());
    }
  }
  Future <List<ChartDataTopProd>?>topProdotti2(String numProd) async {
    Map<String,String> params = Map();
    params["numProdotti"] = numProd;
    final uri = Uri.http(ADDRESS_STORE_SERVER,REQUEST_TOP_PRODUCTS,params);
    try{
      var response = await get(uri);
      //print(response.body);
      return List<ChartDataTopProd>.from(json.decode(response.body)
          .map((i)=>ChartDataTopProd.fromJson(i))
          .toList());
    }catch(e){
      print(e.toString());
    }
  }

  Future<List<DatiOreAcquisti>?>oreGiornoPiuAcquisti() async {
    final uri = Uri.http(ADDRESS_STORE_SERVER,REQUEST_ORE_ACQUISTI,null);
    //print(uri.toString());
    try{
      var response = await get(uri);
      //print(response.body);
      return List<DatiOreAcquisti>.from(json.decode(response.body)
          .map((i)=>DatiOreAcquisti.fromJson(i))
          .toList());
    }catch(e){
      print("sono nel catch "+ e.toString());
    }
  }
  Future<List<DatiGiorniDaAcquistoPrecedente>?>giorniDaAcquistoPrecedente() async {
    final uri = Uri.http(ADDRESS_STORE_SERVER,REQUEST_GIORNI_ACQUISTO,null);
    print(uri.toString());
    try{
      var response = await get(uri);
      //print(response.body);
      return List<DatiGiorniDaAcquistoPrecedente>.from(json.decode(response.body)
          .map((i)=>DatiGiorniDaAcquistoPrecedente.fromJson(i))
          .toList());
    }catch(e){
      print(e.toString());
    }
  }

  Future<List<DatiGiornoSettimana>?>giorniDellaSettimana() async {
    final uri = Uri.http(ADDRESS_STORE_SERVER,REQUEST_GIORNOSETTIMANA,null);
    try{
      var response = await get(uri);
      //print(response.body);
      return List<DatiGiornoSettimana>.from(json.decode(response.body)
          .map((i)=>DatiGiornoSettimana.fromJson(i))
          .toList());
    }catch(e){
      print(e.toString());
    }
  }

  Future<List<ChartDataOggettiOrdine>?>numeroProdottiPerOrdine() async{
    final uri=Uri.http(ADDRESS_STORE_SERVER,REQUEST_PRODUCTS_FOR_ORDER,null);
    try{
      var response = await get(uri);
      print(response.body);
      return List<ChartDataOggettiOrdine>.from(json.decode(response.body)
          .map((i)=>ChartDataOggettiOrdine.fromJson(i))
          .toList());
    }catch(e){
      print(e.toString());
    }
  }

  Future<List<ChartDataDipartimentiProdotti>?>prodottiPerDipartimento()async{
    final uri=Uri.http(ADDRESS_STORE_SERVER,REQUEST_PRODUCTS_FOR_DEPARTMENT,null);
    try{
      var response = await get(uri);
      print(response.body);
      return List<ChartDataDipartimentiProdotti>.from(json.decode(response.body)
          .map((i)=>ChartDataDipartimentiProdotti.fromJson(i))
          .toList());
    }catch(e){
      print(e.toString());
    }
  }


  Future<List<DatiTabellaAssoc>?>regoleAssociazione(String sortBy,int limit)async{
    Map<String,String> params = Map();
    params["sortBy"] = sortBy;
    params["limit"] = limit.toString();
    final uri=Uri.http(ADDRESS_STORE_SERVER,REQUEST_REGOLE_ASSOCIAZIONE,params);
    print(uri.toString());
    try{
      var response = await get(uri);
      print(response.body);
      return List<DatiTabellaAssoc>.from(json.decode(response.body)
          .map((i)=>DatiTabellaAssoc.fromJson(i))
          .toList());
    }catch(e){
      print(e.toString());
    }
  }
  Future<List<ChartDataProdottiCompratiInsieme>?>prodottiCompratiAssieme(int numProdotti)async{
    Map<String,String> params = Map();
    params["numProdotti"] = numProdotti.toString();
    print(params);
    final uri=Uri.http(ADDRESS_STORE_SERVER,REQUEST_BOUGHT_TOGETHER_PRODUCTS,params);
    try{
      print("ciao");
      var response = await get(uri);
      print(response.body);
      print(json.decode(response.body));
      return List<ChartDataProdottiCompratiInsieme>.from(json.decode(response.body)
          .map((i)=>ChartDataProdottiCompratiInsieme.fromJson(i))
          .toList());
    }catch(e){
      print(e.toString());
    }
  }
  Future<Prediction?>predizione(List<String> scontrino) async {
    final uri=Uri.http(ADDRESS_STORE_SERVER,REQUEST_PREDICTION,null);
    String uriStringa=uri.toString()+"?";
    for(int i=0;i<scontrino.length;i++) {
      if (i < scontrino.length - 1)
        uriStringa += "dati=" + scontrino[i] + "&";
      else
        uriStringa += "dati="+ scontrino[i];
    }
    final uriFinale=Uri.parse(uriStringa);
    print(uriFinale);
    try{
      print("ciao");
      var response = await get(uriFinale);
      print(response.body);
      print(json.decode(response.body));
      return Prediction.fromJson(json.decode(response.body));
    }catch(e){
      print(e.toString());
    }
  }



}