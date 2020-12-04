import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/calculatedAnswer.dart';
import 'graph_response.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'loading.dart';
import 'privates.dart';

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
  String hintValue = "Steuerklasse I";
  bool loading = false;

  final formkey = GlobalKey<FormState>();

  final steuerklassen = ['I', 'II', 'III', 'IV', 'V', 'VI'];

  bool validateForm() {
    if (formkey.currentState.validate()) {
      print("validated");
      return true;
    } else {
      print("Not validated");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0XFF518293),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context, '/home'),
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
                      child: Form(
                        key: formkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 7,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
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
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Geburtstag",
                                  ),
                                  controller: gb_controller,
                                  validator: RequiredValidator(
                                      errorText: "Darf nicht leer sein"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Brutto-Verdienst",
                                  ),
                                  controller: brutto_controller,
                                  validator: RequiredValidator(
                                      errorText: "Darf nicht leer sein"),
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false, decimal: true),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "bAV-Beitrag",
                                  ),
                                  controller: bAV_controller,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Darf nicht leer sein"),
                                    BavValidator()
                                  ]),
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
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
                                      hint: Text("$hintValue"),
                                      iconSize: 20,
                                      items: steuerklassen
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (selectedValue) {
                                        setState(() {
                                          for (int i = 0;
                                              i < steuerklassen.length;
                                              i++)
                                            if (steuerklassen[i] ==
                                                selectedValue) {
                                              this.steuerklassen_value = i + 1;
                                            }
                                          hintValue =
                                              "Steuerklasse $selectedValue";
                                          print("$this.steuerklassen_value");
                                          return steuerklassen_value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                FlatButton(
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: FlatButton.icon(
                                      icon: Icon(
                                        Icons.calculate,
                                        color: Colors.white,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      color: Color(0XFF256075),
                                      label: Text(
                                        "Rechnen",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            letterSpacing: 0.5),
                                      ),
                                      onPressed: () async {
                                        if (validateForm() == false) {
                                          null;
                                        } else {
                                          try {
                                            setState(() => loading = true);

                                            final CalculatedGraph graph =
                                                await createUserData(
                                                    gb_controller.text,
                                                    brutto_controller.text,
                                                    bAV_controller.text,
                                                    steuerklassen_value,
                                                    APP_KEY);

                                            final decoded_graph =
                                                base64Decode(graph.image);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CalculatedPage(
                                                  image: decoded_graph,
                                                  nettoAufwand:
                                                      graph.nettoAufwandBAv,
                                                  steuerErsparnis:
                                                      graph.steuerErsparnis,
                                                ),
                                              ),
                                            );
                                            setState(() {
                                              loading = false;
                                              gb_controller.clear();
                                              brutto_controller.clear();
                                              bAV_controller.clear();
                                            });
                                          } catch (e) {
                                            setState(() {
                                              loading = false;
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Server nicht erreichbar"),
                                                      actions: [
                                                        FlatButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pop();
                                                            },
                                                            child: Text("OK"))
                                                      ],
                                                    );
                                                  });
                                            });
                                            print("Bad api response");
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //FlatButton(child: Text("Weiter"),onPressed: ()=>{},)
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ),
          );
  }
}

Future<CalculatedGraph> createUserData(String Geburtstag, String Brutto,
    String bAv_beitrag, int Steuerklasse, String Key) async {
  final String apiUrl = "http://10.0.2.2:5000/userInput";

  final response = await http.post(apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Geburtstag": Geburtstag,
        "Brutto-verdienst": Brutto,
        "bAV": bAv_beitrag,
        "Steuerklasse": Steuerklasse,
        "key": Key
      }));

  if (response.statusCode == 200) {
    final String responseString = response.body;

    return calculatedGraphFromJson(responseString);
  } else {
    return null;
  }
}

class BavValidator extends TextFieldValidator {
  // pass the error text to the super constructor
  BavValidator({String errorText = 'Wert muss im Bereich 0-476 liegen'})
      : super(errorText);
  @override
  bool isValid(String value) {
    // return true if the value is valid according the your condition
    var int_value = int.parse(value);
    if (int_value > 476) {
      return false;
    } else if (int_value < 0) {
      return false;
    } else {
      return true;
    }
  }
}
