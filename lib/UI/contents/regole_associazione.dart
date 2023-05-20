
import 'package:big_data_front_end/UI/screens/Screen.dart';
import 'package:big_data_front_end/UI/contents/predizioni.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../model/support/Model.dart';

class RegoleAssociazione extends StatefulWidget{

  const RegoleAssociazione ({Key?key}) : super(key: key);

  @override
  RegoleAssociazioneState createState() => RegoleAssociazioneState();

}

class RegoleAssociazioneState extends State{

  bool _searching=false;

  List<DatiTabellaAssoc> datas=<DatiTabellaAssoc>[
    DatiTabellaAssoc(antecedente: ["Organic Raspberries","Organic Hass Avocado","Organic Strawberries"], conseguente: ["Bag of Organic Bananas"], confidence: 0.5984251968503937, lift: 5.072272070642333, support: 0.0017376856770495927),
    DatiTabellaAssoc(antecedente: ["Organic Cucumber","Organic Hass Avocado","Organic Strawberries"], conseguente: ["Bag of Organic Bananas"], confidence: 0.546875, lift: 4.635330870478036, support: 0.0010669999771357147),
    DatiTabellaAssoc(antecedente: ["Organic Kiwi","Organic Hass Avocado"], conseguente: ["Bag of Organic Bananas"], confidence:0.5459770114942529, lift: 4.627719489738336, support: 0.001448071397541327),
    DatiTabellaAssoc(antecedente: ["Organic Navel Orange","Organic Raspberries"], conseguente: ["Bag of Organic Bananas"], confidence: 0.5412186379928315, lift: 4.587387356098284, support: 0.0011508356896249496),
  ];

  String messaggioDropDown = "Seleziona ordine di visualizzazione";
  List<String> alternativeSorting = ["confidence","lift","support"];
  String sortingScelto = "confidence";

  String mexLimit= "limit";
  TextEditingController controllerLimit = TextEditingController();

  List<GridColumn>colonne=[
    GridColumn(
        columnName: "Antecedent",
        label: Text("Antecedent")
    ),
    GridColumn(
        columnName: "Consequent",
        label: Text("Consequent")
    ),GridColumn(
        columnName: "Confidence",
        label: Text("Confidence")
    ),
    GridColumn(
        columnName: "Lift",
        label: Text("Lift")
    ),
    GridColumn(
        columnName: "Support",
        label: Text("Support")
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Text(
                'Regole di associazione dei prodotti inferite dai dati',
                style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  hint: Text(messaggioDropDown),
                  items: alternativeSorting.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState((){
                      sortingScelto=value!;
                      messaggioDropDown=value;
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                  width:10 ,
                ),
                SizedBox(
                  height: 28,
                  width: 200,
                  child: TextField(
                    controller: controllerLimit,
                    decoration: InputDecoration(hintText: "Inserisci limite righe"),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async{
                      String controllerText=controllerLimit.text;
                      int limite=10;
                      setState(() {
                        _searching=true;
                      });
                      if(controllerText != "")
                        limite = int.parse(controllerText);
                      var risultato=await Model.sharedInstance.regoleAssociazione(messaggioDropDown, limite);
                      setState(() {
                        _searching=false;
                        datas=risultato!;
                        print(limite);
                      });
                    },
                    child: Text("Cerca")
                ),
              ],
            ),
            Expanded(
              child: _buildDataGrid(),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Screen(page: Predizione())));
                },
                child: Text("Vai alla pagina delle predizioni")
            ),
            bottom(),
          ]
        )
    );
  }

  Widget bottom(){
    if(_searching)
      return CircularProgressIndicator();
    else
      return SizedBox.shrink();
  }

SfDataGrid _buildDataGrid(){
    return SfDataGrid(
        source: DataSourceTabellaAssoc(datiTabella: datas),
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: colonne
    );
  }


}

class DatiTabellaAssoc{
  List<dynamic> antecedente;
  List<dynamic> conseguente;
  double confidence;
  double lift;
  double support;
  DatiTabellaAssoc({required this.antecedente,required this.conseguente,required this.confidence, required this.lift,required this.support});
  factory DatiTabellaAssoc.fromJson(Map<String,dynamic>json){
    return DatiTabellaAssoc(
      antecedente:json['antecedent'],
      conseguente:json['consequent'],
      confidence:json['confidence'],
      lift: json['lift'],
      support: json['support']
    );
  }
}


class DataSourceTabellaAssoc extends DataGridSource{


  DataSourceTabellaAssoc({required List<DatiTabellaAssoc> datiTabella}){
    dataGridRows=datiTabella.map<DataGridRow>((dataGridRow)=>
        DataGridRow(cells: [
          DataGridCell<List<dynamic>>(columnName: "Antecedent", value: dataGridRow.antecedente),
          DataGridCell<List<dynamic>>(columnName: "Consequent", value: dataGridRow.conseguente),
          DataGridCell<double>(columnName: "Confidence", value: dataGridRow.confidence),
          DataGridCell<double>(columnName: "Lift", value: dataGridRow.lift),
          DataGridCell<double>(columnName: "Support", value: dataGridRow.support)
        ])).toList();
  }

  List<DataGridRow>dataGridRows=[];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell){
      return Container(
        child: Text (
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis
        ),
      );
    }).toList());
  }
}















