import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'graph_response.dart';
import 'dart:convert';
//import 'landing_page.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final gb_controller = TextEditingController();
  final brutto_controller = TextEditingController();
  final bAV_controller = TextEditingController();
  int steuerklassen_value = 1;
  String selectedValue = "Steuerklasse";

  final steuerklassen = ['I','II','III','IV','V','VI'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text("Provisions Rechner"),
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.fromLTRB(50, 50, 50, 100),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Geburtstag",
                    ),
                    controller: gb_controller,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Brutto-Verdienst",
                    ),
                    controller: brutto_controller,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "bAV-Beitrag",
                    ),
                    controller: bAV_controller,
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.amber,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[400], //                   <--- border color
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        hint: Text(selectedValue),
                        iconSize: 20,
                        items: steuerklassen.map((String dropDownStringItem) {
                          return DropdownMenuItem(
                            value:dropDownStringItem,
                            child: Text(dropDownStringItem),

                          );
                        }).toList(),
                        onChanged: (selectedValue){
                          setState(() {
                            for (int i = 1; i <= steuerklassen.length; i++)
                              if (steuerklassen[i] == selectedValue) {
                                this.steuerklassen_value = i + 1;
                              }
                            //value: selectedValue;
                            return steuerklassen_value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FlatButton.icon(
        icon: Icon(Icons.calculate),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        color: Colors.white,
        label: Text("Provision errechnen"),
        onPressed: () async {
          AlertDialog(
            title: Text("Bitte alle Felder eingeben"),
          );

          final CalculatedGraph graph = await createUserData(gb_controller.text,
              brutto_controller.text, bAV_controller.text, steuerklassen_value);

          //json_response = get_image();

          Navigator.pushNamed(context, '/calculatedAnswer');
        },
      ),
    );
  }
}



Future<CalculatedGraph> createUserData(String Geburtstag, String Brutto,
    String bAv_beitrag, int Steuerklasse) async {
  final String apiUrl = "http://10.0.2.2:5000/userInput";

  final response = await http.post(apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Geburtstag": Geburtstag,
        "Brutto-verdienst": Brutto,
        "bAV": bAv_beitrag,
        "Steuerklasse": Steuerklasse
      }));

  if (response.statusCode == 201) {
    final String responseString = response.body;

    return calculatedGraphFromJson(responseString);
  } else {
    return null;
  }
}