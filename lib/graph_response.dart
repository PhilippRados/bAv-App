// // To parse this JSON data, do
// //
// //     final calculatedGraph = calculatedGraphFromJson(jsonString);

// import 'dart:convert';

// CalculatedGraph calculatedGraphFromJson(String str) => CalculatedGraph.fromJson(json.decode(str));

// String calculatedGraphToJson(CalculatedGraph data) => json.encode(data.toJson());

// class CalculatedGraph {
//   CalculatedGraph({
//     this.image,
//   });

//   String image;

//   factory CalculatedGraph.fromJson(Map<String, dynamic> json) => CalculatedGraph(
//     image: json["image"],
//   );

//   Map<String, dynamic> toJson() => {
//     "image": image,
//   };
// }

import 'dart:convert';

CalculatedGraph calculatedGraphFromJson(String str) =>
    CalculatedGraph.fromJson(json.decode(str));

String calculatedGraphToJson(CalculatedGraph data) =>
    json.encode(data.toJson());

class CalculatedGraph {
  CalculatedGraph({
    this.image,
    this.nettoAufwandBAv,
    this.steuerErsparnis,
  });

  String image;
  String nettoAufwandBAv;
  String steuerErsparnis;

  factory CalculatedGraph.fromJson(Map<String, dynamic> json) =>
      CalculatedGraph(
        image: json["image"],
        nettoAufwandBAv: json["NettoAufwand_bAV"],
        steuerErsparnis: json["SteuerErsparnis"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "NettoAufwand_bAV": nettoAufwandBAv,
        "SteuerErsparnis": steuerErsparnis,
      };
}
