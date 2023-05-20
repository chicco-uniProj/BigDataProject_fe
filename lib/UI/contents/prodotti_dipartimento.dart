


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/support/Model.dart';

class ProdottiVendutiDipartimento extends StatefulWidget {
  const ProdottiVendutiDipartimento({Key? key}) : super(key: key);

  @override
  _ProdottiDipartimentoState createState() => _ProdottiDipartimentoState();
}

class _ProdottiDipartimentoState extends State {
  List<ChartDataDipartimentiProdotti>lista=<ChartDataDipartimentiProdotti>[
    ChartDataDipartimentiProdotti(dipartimento: "breakfast", numProdVenduti: 739069),
    ChartDataDipartimentiProdotti(dipartimento: "alcohol",numProdVenduti: 159294),
    ChartDataDipartimentiProdotti(dipartimento:"bulk",numProdVenduti:35932)
  ];
  bool _searching=false;
  late List<ChartDataDipartimentiProdotti>risultato;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildSmartLabelPieChart()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    setState((){_searching=true;});
                    risultato= (await Model.sharedInstance.prodottiPerDipartimento())!;
                    setState(() {
                      _searching=false;
                      lista=risultato;
                    });
                  },
                  child: Text("Click per grafico completo")
              ),
            ],
          ),
          bottom()
        ],
      )
    );
  }

  SfCircularChart _buildSmartLabelPieChart() {
    return SfCircularChart(
      title: ChartTitle(text: 'Distribuzione dei prodotti venduti per reparto',textStyle: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
      series: _gettSmartLabelPieSeries(),
    );
  }
  List<PieSeries<ChartDataDipartimentiProdotti, String>> _gettSmartLabelPieSeries() {
    return <PieSeries<ChartDataDipartimentiProdotti, String>>[
      PieSeries<ChartDataDipartimentiProdotti, String>(
          dataSource: lista,
          xValueMapper: (ChartDataDipartimentiProdotti data, _) => data.dipartimento,
          yValueMapper: (ChartDataDipartimentiProdotti data, _) => data.numProdVenduti,
          dataLabelMapper: (ChartDataDipartimentiProdotti data, _) => data.dipartimento,
          radius: '55%',
          dataLabelSettings: const DataLabelSettings(isVisible: true,labelPosition: ChartDataLabelPosition.outside,textStyle: TextStyle(fontSize: 20))
      )
    ];
  }
  Widget bottom(){
    if(_searching)
      return CircularProgressIndicator();
    else
      return SizedBox.shrink();
  }
}

class ChartDataDipartimentiProdotti {
  String dipartimento;
  int numProdVenduti;
  ChartDataDipartimentiProdotti({required this.dipartimento,required this.numProdVenduti});
  factory ChartDataDipartimentiProdotti.fromJson(Map<String,dynamic>json){
    return ChartDataDipartimentiProdotti(
      dipartimento:json['department'],
      numProdVenduti:json['numProdottiVenduti'],
    );
  }
}