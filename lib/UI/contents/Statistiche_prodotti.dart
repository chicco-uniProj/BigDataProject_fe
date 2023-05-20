

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/support/Model.dart';

class StatisticheProdotti extends StatefulWidget {
  const StatisticheProdotti({Key? key}) : super(key: key);

  @override
  StatisticheProdottiState createState() => StatisticheProdottiState();


}
class StatisticheProdottiState extends State {

  List<DatiOreAcquisti>valoriOreAqcuisti=<DatiOreAcquisti>[
    DatiOreAcquisti(ora: 0, count: 22758),
    DatiOreAcquisti(ora: 1 , count: 12398),
    DatiOreAcquisti(ora: 2 , count: 7539),
    DatiOreAcquisti(ora: 3 , count: 5474),
    DatiOreAcquisti(ora: 4 , count: 5527),
    DatiOreAcquisti(ora: 5 , count: 9569)
  ];
  late List<DatiOreAcquisti> resultOreAquisti;


  List<DatiGiornoSettimana>valoriGiornoSeettimana=<DatiGiornoSettimana>[
    DatiGiornoSettimana(giornoStr: "Domenica", count: 600905),
    DatiGiornoSettimana(giornoStr: "Lunedì", count: 587478),
    DatiGiornoSettimana(giornoStr: "Martedì", count: 467260),

  ];
  late List<DatiGiornoSettimana> resultGiornoSettimana;



  List<DatiGiorniDaAcquistoPrecedente>valoriGiornoAcquisti= <DatiGiorniDaAcquistoPrecedente>[
    DatiGiorniDaAcquistoPrecedente(numGiorni: 0.0,count: 67755),
    DatiGiorniDaAcquistoPrecedente(numGiorni: 1.0,count: 145247),
    DatiGiorniDaAcquistoPrecedente(numGiorni: 2.0,count: 193206),
    DatiGiorniDaAcquistoPrecedente(numGiorni: 3.0,count: 217005),
    DatiGiorniDaAcquistoPrecedente(numGiorni: 4.0,count: 221696),
    DatiGiorniDaAcquistoPrecedente(numGiorni: 5.0,count: 214503),
  ];
  late List<DatiGiorniDaAcquistoPrecedente>resulGiornoAcquisti;



  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Column(
          children: [
            Text(
                'Statistiche temporali sugli acquisti',
                style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)
            ),
            Row(
              children: [
                SizedBox(
                  height: 328,
                  width: 450,
                  child: Column(
                    children: [
                      Expanded(
                        child: _buildDefaultDateTimeAxisChart(),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            resultOreAquisti=(await Model.sharedInstance.oreGiornoPiuAcquisti())!;
                            setState(() {
                              valoriOreAqcuisti=resultOreAquisti;
                            });
                          },
                          child: Text("Click per grafico completo")
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 328,
                  width: 450,
                  child: Column(
                    children: [
                      Expanded(
                        child: _buildRoundedColumnChart(),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            resultGiornoSettimana=(await Model.sharedInstance.giorniDellaSettimana())!;
                            setState(() {
                              valoriGiornoSeettimana=resultGiornoSettimana;
                            });
                          },
                          child: Text("Click per grafico completo")
                      )
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 328,
              width: 900,
              child: Column(
                children: [
                  Expanded(
                    child:_buildDefaultColumnChart() ,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        resulGiornoAcquisti=(await Model.sharedInstance.giorniDaAcquistoPrecedente())!;
                        setState(() {
                          valoriGiornoAcquisti=resulGiornoAcquisti;
                        });
                      },
                      child: Text("Click per grafico completo")
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }

  SfCartesianChart _buildDefaultDateTimeAxisChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(
            text: "Prodotti acquistati in base all'ora del giorno"
        ),
        primaryXAxis: NumericAxis(interval: 1),
        primaryYAxis: NumericAxis(),
        series: _getDefaultDateTimeSeries(),
        trackballBehavior: TrackballBehavior(enable: true,activationMode: ActivationMode.singleTap,tooltipSettings: InteractiveTooltip(format: 'point.x:point.y'))
    );
  }
  List<LineSeries<DatiOreAcquisti, int>> _getDefaultDateTimeSeries() {
    return <LineSeries<DatiOreAcquisti,int>>[
      LineSeries<DatiOreAcquisti, int>(
        dataSource:valoriOreAqcuisti,
        xValueMapper: (DatiOreAcquisti data, _) => data.ora,
        yValueMapper: (DatiOreAcquisti data, _) => data.count,
        color: const Color.fromRGBO(242, 117, 7, 1),
      )
    ];
  }

  SfCartesianChart _buildRoundedColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Prodotti acquistati in base al giorno della settimana'),
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(color: Colors.white),
        axisLine: const AxisLine(width: 0),
        labelPosition: ChartDataLabelPosition.inside,
        majorTickLines: const MajorTickLines(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(isVisible: false, minimum: 0),
      series: _getRoundedColumnSeries(),
      tooltipBehavior: TooltipBehavior(),
    );
  }

  /// Get rounded corner column series
  List<ColumnSeries<DatiGiornoSettimana, String>> _getRoundedColumnSeries() {
    return <ColumnSeries<DatiGiornoSettimana, String>>[
      ColumnSeries<DatiGiornoSettimana, String>(
        width: 0.9,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: valoriGiornoSeettimana,
        borderRadius: BorderRadius.circular(30),
        xValueMapper: (DatiGiornoSettimana data, _) => data.giornoStr,
        yValueMapper: (DatiGiornoSettimana data, _) => data.count,
        color: Colors.lightGreen,
      ),
    ];
  }



  SfCartesianChart _buildDefaultColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Andamento dei giorni da precedente acquisto'),
      primaryXAxis: NumericAxis(minimum:-1 ,interval: 1),
      primaryYAxis: NumericAxis(),
      series: _getDefaultColumnSeries(),
      tooltipBehavior: TooltipBehavior(enable: true,),
    );
  }

  List<ColumnSeries<DatiGiorniDaAcquistoPrecedente, double>> _getDefaultColumnSeries() {
    return <ColumnSeries<DatiGiorniDaAcquistoPrecedente,double>>[
      ColumnSeries<DatiGiorniDaAcquistoPrecedente, double>(
        dataSource: valoriGiornoAcquisti,
        xValueMapper: (DatiGiorniDaAcquistoPrecedente data, _) => data.numGiorni,
        yValueMapper: (DatiGiorniDaAcquistoPrecedente data, _) => data.count,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}



class DatiOreAcquisti{
  int ora;
  double count;
  DatiOreAcquisti({required this.ora,required this.count});
  factory DatiOreAcquisti.fromJson(Map<String,dynamic>json){
    return DatiOreAcquisti(
      ora:json['order_hour_of_day'],
      count:json['count'],
    );
  }
}

class DatiGiornoSettimana{
  String giornoStr;
  int count;
  DatiGiornoSettimana({required this.giornoStr,required this.count});
  factory DatiGiornoSettimana.fromJson(Map<String,dynamic>json){
    final giorni=["Domenica","Lunedi","Martedì","Mercoledì","Giovedì","Venerdì","Sabato"];
    int giornoNum = json['order_dow'];
    return DatiGiornoSettimana(
        giornoStr: giorni[giornoNum],
        count : json['count']
    );
  }

}

class DatiGiorniDaAcquistoPrecedente{
  double numGiorni;
  int count;
  DatiGiorniDaAcquistoPrecedente({required this.numGiorni,required this.count});
  factory DatiGiorniDaAcquistoPrecedente.fromJson(Map<String,dynamic>json){
    return DatiGiorniDaAcquistoPrecedente(
      numGiorni:json['days_since_prior_order'],
      count:json['count'],
    );
  }

}