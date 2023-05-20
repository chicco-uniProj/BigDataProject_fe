import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/support/Model.dart';
import '../../model/support/constants.dart';



class Predizione extends StatefulWidget {
  Predizione({Key? key}) : super(key: key);
  @override
  _PredizioneState createState() => _PredizioneState();
}

class _PredizioneState extends State{

  bool _searching=false;
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  late Prediction p=Prediction(lista:[]);
  late Prediction pRisposta;
  List<String>scontrino=[];
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Column(
        children: [
          Text(
              'Predizione sugli acquisti',
              style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)
          ),
          Row(
            children:[
              Expanded(
                child: TextField(
                    decoration: InputDecoration(
                        border:OutlineInputBorder(),
                        labelText:"Se ho comprato:"),
                    controller:_controller,
                  onSubmitted: (value) {
                      setState(() {
                        scontrino.add(value);
                      });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:scontrino.length,
                  itemBuilder: (_,index)=>Text(scontrino[index]),
                ),
              ),
              ElevatedButton(
                  onPressed: ()  {
                    setState((){scontrino.clear();});
                  },
                  child: Text("Pulisci lista!!")
              ),
            ]
          ),
          ElevatedButton(
              onPressed: () async {
                setState((){_searching=true;});
                pRisposta= (await Model.sharedInstance.predizione(scontrino))!;
                setState(() {
                  _searching=false;
                  p=pRisposta;
                });
              },
              child: Text("Effettua predizione!!!")
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap:true,
              itemCount: p.lista.length,
              itemBuilder:(_,index)=>Text(p.lista[index])
            ),
          ),
        ],
      )
    );
  }
}

class Prediction {
  List<String>lista;
  Prediction({required this.lista});

  factory Prediction.fromJson(Map<dynamic,dynamic>json){
    //print("Ciao3"+json.toString());
    List<dynamic>rawItems=json['suggestions'];//ho fixato cosi(non ho idea del perche funzioni)
    List<String>pippo=rawItems.map((i)=>i.toString()).toList();
    //print("Ciao4"+pippo.toString());
    return Prediction(
      lista:pippo,
    );
  }
}