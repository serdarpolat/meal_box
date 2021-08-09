import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_box/models/Menu.dart';
import 'package:meal_box/views/List_Item/ListItem.dart';
import 'package:yaml/yaml.dart';
import "package:flutter/services.dart" as s;

Future<List<Menu>> getData() async {
  final data = await s.rootBundle.loadString('assets/documents/menu.yaml');
  final mapData = loadYaml(data);
  return MainModel.fromJson(mapData).menus;
}

final menus = FutureProvider<List<Menu>>((ref) => getData());

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final future = watch(menus);

    return future.when(
      data: (data) {
        var mainMenu = data[0].items;
        return ListItem(
          items: mainMenu,
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text("ERROR : $error"),
    );
  }
}
