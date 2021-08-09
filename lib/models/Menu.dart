// To parse this JSON data, do
//
//     final mainModel = mainModelFromJson(jsonString);

import 'dart:convert';

import 'Item.dart';

MainModel mainModelFromJson(String str) => MainModel.fromJson(json.decode(str));

String mainModelToJson(MainModel data) => json.encode(data.toJson());

class MainModel {
  MainModel({
    required this.menus,
  });

  List<Menu> menus;

  factory MainModel.fromJson(Map<dynamic, dynamic> json) => MainModel(
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    required this.key,
    required this.description,
    required this.items,
    this.orderTag,
  });

  String key;
  String description;
  List<Item> items;
  String? orderTag;

  factory Menu.fromJson(Map<dynamic, dynamic> json) => Menu(
        key: json["key"],
        description: json["description"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        orderTag: json["orderTag"] == null ? null : json["orderTag"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "description": description,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "orderTag": orderTag == null ? null : orderTag,
      };
}
