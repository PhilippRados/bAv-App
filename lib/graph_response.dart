// To parse this JSON data, do
//
//     final calculatedGraph = calculatedGraphFromJson(jsonString);

import 'dart:convert';

CalculatedGraph calculatedGraphFromJson(String str) => CalculatedGraph.fromJson(json.decode(str));

String calculatedGraphToJson(CalculatedGraph data) => json.encode(data.toJson());

class CalculatedGraph {
  CalculatedGraph({
    this.image,
  });

  String image;

  factory CalculatedGraph.fromJson(Map<String, dynamic> json) => CalculatedGraph(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}
