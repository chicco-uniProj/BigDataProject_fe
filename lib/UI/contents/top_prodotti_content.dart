import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/support/Model.dart';
import '../../model/support/constants.dart';
import '../../model/support/responsive.dart';


class TopProdottiContent extends StatefulWidget {
  const TopProdottiContent({Key? key}) : super(key: key);

  @override
  _TopProdottiState createState() => _TopProdottiState();


}
class _TopProdottiState extends State{

  String numeroTop = '5';
  static const List<String> alternativeTop = <String>['2','3','4','5','6','7'];

  late List<ChartDataTopProd>result;
  late ChartDataTopProd others;

  bool _searching=false;

  List<ChartDataTopProd>valoriPiramide=<ChartDataTopProd>[
    ChartDataTopProd(prodotto: "Banana", sales: 472565),
    ChartDataTopProd(prodotto: "Bags of Organic Bananas", sales: 394930),
    ChartDataTopProd(prodotto: "Organic Strawberries", sales: 275577),
  ];
  List<ChartDataTopProd>valoriGraficoTorta = <ChartDataTopProd>[
    ChartDataTopProd(prodotto: "Banana", sales: 472565),
    ChartDataTopProd(prodotto: "Bags of Organic Bananas", sales: 394930),
    ChartDataTopProd(prodotto: "Organic Strawberries", sales: 275577),
    ChartDataTopProd(prodotto:"others", sales:32896895)
  ];


  String messaggioDropDown="Seleziona quanti prodotti visualizzare";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
              'Prodotti più venduti',
              style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: DropdownButton(
                    hint: Text(messaggioDropDown),
                    items: alternativeTop.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState((){
                        numeroTop=value!;
                        messaggioDropDown=value;
                        print(numeroTop);
                      });
                    },
                  )
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      setState((){
                        _searching=true;
                      });
                      result=(await Model.sharedInstance.topProdotti2(numeroTop))!;
                      setState(() {
                        _searching=false;
                        valoriGraficoTorta=result;
                        others=result.removeLast();
                        valoriPiramide=result;
                      });
                      //print(ciao.toString());
                      print(result.toString());
                    },
                    child: Text("Cerca")
                ),
              )
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    child: _buildDefaultPyramidChart(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    child: _buildSmartLabelPieChart(),
                  ),
                ),
              ],
            ),
          ),
          bottom(),
        ],
      ),

    );
  }
  Widget bottom(){
    if(_searching)
      return CircularProgressIndicator();
    else
      return SizedBox.shrink();
  }

  ///Get the default pyramid chart
  SfPyramidChart _buildDefaultPyramidChart() {
    return SfPyramidChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      series: _getPyramidSeries(),
    );
  }

  ///Get the default pyramid series
  PyramidSeries<ChartDataTopProd, String> _getPyramidSeries() {
    return PyramidSeries<ChartDataTopProd, String>(
        dataSource: valoriPiramide,
        gapRatio: 0.2,
        pyramidMode: PyramidMode.surface,
        height: '90%',
        xValueMapper: (ChartDataTopProd data, _) => data.prodotto,
        yValueMapper: (ChartDataTopProd data, _) => data.sales,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
        ));
  }
  SfCircularChart _buildSmartLabelPieChart() {
    return SfCircularChart(
      series: _gettSmartLabelPieSeries(),
    );
  }
  List<PieSeries<ChartDataTopProd, String>> _gettSmartLabelPieSeries() {
    return <PieSeries<ChartDataTopProd, String>>[
      PieSeries<ChartDataTopProd, String>(
          dataSource: valoriGraficoTorta,
          xValueMapper: (ChartDataTopProd data, _) => data.prodotto,
          yValueMapper: (ChartDataTopProd data, _) => data.sales,
          dataLabelMapper: (ChartDataTopProd data, _) => data.prodotto,
          radius: '55%',
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 8),
            labelPosition: ChartDataLabelPosition.outside
          )
      )
    ];
  }



}

class ChartDataTopProd {

  String prodotto;
  int sales;
  ChartDataTopProd({required this.prodotto,required this.sales});

  factory ChartDataTopProd.fromJson(Map<String,dynamic>json){
    return ChartDataTopProd(
      prodotto:json['product_name'],
      sales:json['count'],
    );
  }

  String toString(){
    return prodotto+" "+sales.toString();
  }

}