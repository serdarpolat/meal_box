import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_box/models/DiscountMenu.dart';
import 'package:meal_box/views/Appbar.dart';
import 'package:meal_box/views/ChooseProduct.dart';
import 'package:yaml/yaml.dart';
import "package:flutter/services.dart" as s;
import 'package:meal_box/models/Item.dart';
import 'package:meal_box/models/Menu.dart';
import 'package:meal_box/src/Extensions.dart';

Future<List<Menu>> getData() async {
  final data = await s.rootBundle.loadString('assets/documents/menu.yaml');
  final mapData = loadYaml(data);
  return MainModel.fromJson(mapData).menus;
}

final menus = FutureProvider<List<Menu>>((ref) => getData());

class SubItems extends ConsumerWidget {
  final List<dynamic>? submenus;
  final String? header;
  final DiscountMenu discountMenu;
  const SubItems(
      {Key? key, this.submenus, this.header, required this.discountMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Size s = MediaQuery.of(context).size;
    final future = watch(menus);

    return Scaffold(
      appBar: appBar(),
      body: future.when(
        data: (data) {
          List<Menu> filteredMenu = [];
          for (var submenu in submenus!) {
            for (var menu in data) {
              if (menu.key == submenu) {
                filteredMenu.add(menu);
              }
            }
          }
          return Container(
            width: s.width,
            height: s.height,
            child: Column(
              children: [
                Container(
                  width: s.width,
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    header == null ? "Ana Menü" : header.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: s.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          filteredMenu.length,
                          (index) {
                            Menu menu = filteredMenu[index];
                            List<Item> items = filteredMenu[index].items;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: MaterialButton(
                                onPressed: () {
                                  ChooseProduct(
                                    header: menu.description,
                                    items: items,
                                    discountMenu: discountMenu,
                                    subItemIndex: index,
                                  ).push(context);
                                },
                                height: 64,
                                minWidth: s.width * 0.9,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Color(0xffc00d11),
                                child: Text(
                                  menu.description,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text("ERROR : $error"),
      ),
    );
  }
}
