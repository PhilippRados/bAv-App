import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/calculatedAnswer.dart';
import 'graph_response.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

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

  final steuerklassen = ['I', 'II', 'III', 'IV', 'V', 'VI'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF256075),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context, '/home');
                },
                icon: Icon(CupertinoIcons.arrowtriangle_left_fill),
                color: Colors.white,
                //label: Text(""),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 70.0, 18.0, 20),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Eingabe",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50.0)),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //margin: EdgeInsets.only(top:80),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 40, 0),
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
                            color: Colors.grey[
                                400], //                   <--- border color
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            hint: Text(selectedValue),
                            iconSize: 20,
                            items:
                                steuerklassen.map((String dropDownStringItem) {
                              return DropdownMenuItem(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (selectedValue) {
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
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 15),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: FlatButton.icon(
            icon: Icon(
              Icons.calculate,
              color: Colors.white,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Color(0XFF256075),
            label: Text(
              "Rechnen",
              style: TextStyle(
                  fontSize: 17, color: Colors.white, letterSpacing: 0.5),
            ),
            onPressed: () async {
              AlertDialog(
                title: Text("Bitte alle Felder eingeben"),
              );

              final CalculatedGraph graph = await createUserData(
                  gb_controller.text,
                  brutto_controller.text,
                  bAV_controller.text,
                  steuerklassen_value);

              //json_response = get_image();
              print(graph.image);

              final decoded_graph = base64Decode(graph.image);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalculatedPage(image: decoded_graph),
                ),
              );
            },
          ),
        ),
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

  if (response.statusCode == 200) {
    final String responseString = response.body;

    //return responseString;
    return calculatedGraphFromJson(responseString);
  } else {
    return null;
  }
}
