import 'package:meal_box/models/Menu.dart';
import 'package:yaml/yaml.dart';
import "package:flutter/services.dart" as s;

class MenuService {
  Future<List<Menu>> getData() async {
    final data = await s.rootBundle.loadString('assets/documents/menu.yaml');
    final mapData = loadYaml(data);
    return MainModel.fromJson(mapData).menus;
  }
}
