

import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/support/Model.dart';
import '../../model/support/constants.dart';



class Grafico_colonne extends StatefulWidget {
  Grafico_colonne({Key? key}) : super(key: key);

  @override
  _GraficoColonneState createState() => _GraficoColonneState();
}

class _GraficoColonneState extends State<Grafico_colonne> {



@override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top prodotti più venduti',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),

          TextButton(onPressed: () async {
            List<String>?ciao= await
            Model.sharedInstance.department();
            print(ciao.toString());
            },
            child: Text("suca")),
          Expanded(
            child: _buildRoundedColumnChart(),
          )
        ],
      ),
    );
  }

  /// Get rounded corner column chart
  SfCartesianChart _buildRoundedColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(color: Colors.white),
        axisLine: const AxisLine(width: 0),
        labelPosition: ChartDataLabelPosition.inside,
        majorTickLines: const MajorTickLines(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(isVisible: false, minimum: 0, maximum: 9000),
      series: _getRoundedColumnSeries(),
    );
  }

  /// Get rounded corner column series
  List<ColumnSeries<ChartDataTopProd, String>> _getRoundedColumnSeries() {
    return <ColumnSeries<ChartDataTopProd, String>>[
      ColumnSeries<ChartDataTopProd, String>(
        width: 0.9,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: <ChartDataTopProd>[
          ChartDataTopProd('Banana',4725),
          ChartDataTopProd('Organic', 3794),
          ChartDataTopProd('Strawberries',2646),
          ChartDataTopProd('Spinach', 2419),
          ChartDataTopProd('Avocado', 1768),
        ],

        /// If we set the border radius value for column series,
        /// then the series will appear as rounder corner.
        borderRadius: BorderRadius.circular(10),
        xValueMapper: (ChartDataTopProd sales, _) => sales.citta as String,
        yValueMapper: (ChartDataTopProd sales, _) => sales.sales,
      ),
    ];
  }
}

class ChartDataTopProd {

  final String citta;
  final int sales;



  ChartDataTopProd(this.citta,this.sales);
}
