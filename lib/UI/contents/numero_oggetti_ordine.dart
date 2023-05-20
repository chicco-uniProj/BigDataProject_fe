
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../model/support/Model.dart';

class NumeroOggettiInOrdine extends StatefulWidget {
  const NumeroOggettiInOrdine({Key? key}) : super(key: key);

  @override
  _NumeroOggettiInOrdineState createState() => _NumeroOggettiInOrdineState();
}

class _NumeroOggettiInOrdineState extends State {
  List<ChartDataOggettiOrdine>lista=<ChartDataOggettiOrdine>[
    ChartDataOggettiOrdine(numProdotti: 1,count: 163593),
    ChartDataOggettiOrdine(numProdotti: 2,count: 194361),
    ChartDataOggettiOrdine(numProdotti: 3,count: 215060),
    ChartDataOggettiOrdine(numProdotti: 4,count: 230299),
    ChartDataOggettiOrdine(numProdotti: 5,count: 237225),
  ];
  bool _searching=false;
  late List<ChartDataOggettiOrdine>risultato;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: _buildDefaultColumnChart()
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState((){_searching=true;});
                        risultato= (await Model.sharedInstance.numeroProdottiPerOrdine())!;
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
            ]
        )
    );
  }
  SfCartesianChart _buildDefaultColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Andamento del numero di ordini in base alla dimensione del carrello',textStyle: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
      primaryXAxis: NumericAxis(title: AxisTitle(text:"Numero Prodotti in ordine"),minimum:0,interval:1),
      primaryYAxis: NumericAxis(title: AxisTitle(text:"Count"),labelPosition: ChartDataLabelPosition.outside),
      series: getDefaultColumnSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<ColumnSeries<ChartDataOggettiOrdine, int>> getDefaultColumnSeries() {
    return <ColumnSeries<ChartDataOggettiOrdine,int>>[
      ColumnSeries<ChartDataOggettiOrdine, int>(
        dataSource: lista,
        xValueMapper: (ChartDataOggettiOrdine data, _) => data.numProdotti,
        yValueMapper: (ChartDataOggettiOrdine data, _) => data.count,
        dataLabelSettings: const DataLabelSettings(
            isVisible: false),
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

class ChartDataOggettiOrdine {

  int numProdotti;
  int count;
  ChartDataOggettiOrdine({required this.numProdotti,required this.count});

  factory ChartDataOggettiOrdine.fromJson(Map<String,dynamic>json){
    return ChartDataOggettiOrdine(
      numProdotti:json['numProdotti'] as int,
      count:json['count'],
    );
  }

  String toString(){
    return numProdotti.toString()+" "+count.toString();
  }
}
