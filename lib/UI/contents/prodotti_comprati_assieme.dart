import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/support/Model.dart';

class ProdottiCompratiAssieme extends StatefulWidget {
  const ProdottiCompratiAssieme({Key? key}) : super(key: key);

  @override
  _ProdottiCompratiAssiemeState createState() => _ProdottiCompratiAssiemeState();
}

class _ProdottiCompratiAssiemeState extends State {
  List<ChartDataProdottiCompratiInsieme>lista=<ChartDataProdottiCompratiInsieme>[
    ChartDataProdottiCompratiInsieme(prodotti: ["Organic Hass Avocado","OrganicStrawberries","Bag of Organic Banana"], frequenza: 710),
    ChartDataProdottiCompratiInsieme(prodotti: ["Organic Raspberries","Organic Strawberries","Bag of Organic Bananas"],frequenza: 649),
    ChartDataProdottiCompratiInsieme(prodotti:["Organic Baby Spinach","Organic Strawberries","Bag of Organic Bananas"],frequenza: 587)
  ];
  List<int>alternativeNumProdotti=[2,3,4];
  bool _searching=false;
  int numeroProdotti=3;
  late List<ChartDataProdottiCompratiInsieme>prova;
  String messaggioDropDown="Voglio liste lunghe almeno:";
  late List<ChartDataProdottiCompratiInsieme>risultato;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Gruppi di prodotti comprati insieme',
                style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)
            ),
            Center(
                child: DropdownButton(
                  hint: Text(messaggioDropDown),
                  items: alternativeNumProdotti.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState((){
                      numeroProdotti=value!;
                      messaggioDropDown=value.toString();
                      print(numeroProdotti);
                    });
                  },
                )
            ),
            Expanded(child: _buildHorizontalBarChart()),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      setState((){_searching=true;});
                      risultato= (await Model.sharedInstance.prodottiCompratiAssieme(numeroProdotti))!;
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

  SfCartesianChart _buildHorizontalBarChart() {
    return SfCartesianChart(
      title: ChartTitle(
          text:'Liste di prodotti comprati con le relative frequenze'),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        title: AxisTitle(text:"Liste di prodotti")
      ),
      primaryYAxis: NumericAxis(title: AxisTitle(text:"Frequenza"),labelPosition: ChartDataLabelPosition.outside),
      series: getDefaultColumnSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
  List<BarSeries<ChartDataProdottiCompratiInsieme, String>> getDefaultColumnSeries() {
    return <BarSeries<ChartDataProdottiCompratiInsieme,String>>[
      BarSeries<ChartDataProdottiCompratiInsieme, String>(
        dataSource: lista,
        xValueMapper: (ChartDataProdottiCompratiInsieme data, _) => data.prodotti.toString(),
        yValueMapper: (ChartDataProdottiCompratiInsieme data, _) => data.frequenza,
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
/*
class ChartDataProdottiCompratiInsieme {
  List<String> prodotti;
  int frequenza;
  ChartDataProdottiCompratiInsieme({required this.prodotti,required this.frequenza});
  factory ChartDataProdottiCompratiInsieme.fromJson(Map<dynamic,dynamic>json){
    //print("Ciao3"+json.toString());
    List<dynamic>rawItems=json['items'];//ho fixato cosi(non ho idea del perche funzioni)
    List<String>pippo=rawItems.map((i)=>i.toString()).toList();
    //print("Ciao4"+pippo.toString());
    return ChartDataProdottiCompratiInsieme(
      prodotti:pippo,
      frequenza:json['freq'],//qua si rompeva perche sono down e avevo lasciato il nome dell'altra cosa
    );
  }
}
 */

class ChartDataProdottiCompratiInsieme {
  List<dynamic> prodotti;
  int frequenza;
  ChartDataProdottiCompratiInsieme({required this.prodotti,required this.frequenza});
  factory ChartDataProdottiCompratiInsieme.fromJson(Map<dynamic,dynamic>json){
    return ChartDataProdottiCompratiInsieme(
      prodotti:json['items'],
      frequenza:json['freq'],//qua si rompeva perche sono down e avevo lasciato il nome dell'altra cosa
    );
  }
}