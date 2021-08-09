import 'package:flutter/material.dart';
import 'package:meal_box/models/DiscountMenu.dart';
import 'package:meal_box/models/Item.dart';
import 'package:meal_box/models/Product.dart';
import 'package:meal_box/src/Extensions.dart';
import 'package:meal_box/src/providers.dart';
import 'package:meal_box/views/List_Item/Widgets.dart';
import 'package:meal_box/views/Sub_Item/SubItems.dart';
import 'package:meal_box/views/Appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListItem extends StatelessWidget {
  final List<Item>? items;
  final String? header;
  const ListItem({Key? key, this.items, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(),
      body: Container(
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
              child: GridView.count(
                crossAxisCount: 2,
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 3.5 / 4,
                padding: EdgeInsets.all(16),
                children: List.generate(
                  items!.length,
                  (index) {
                    var item = items![index];
                    var img = item.image.toString();
                    img = img.replaceFirst(".", "assets");

                    return ProductItem(
                      item: item,
                      img: img,
                      onPressed: () {
                        var items = item.items;
                        var discountMenu = DiscountMenu(null, null, null, null);

                        if (item.price != null && item.subMenus == null) {
                          var price = pricetoDouble(item.price);
                          var product = Product(item.caption!, price);

                          context
                              .read(orderProvider.notifier)
                              .addProduct(product);

                          context
                              .read(priceProvider.notifier)
                              .incrementPrice(price);
                        }

                        if (item.price != null && item.subMenus != null) {
                          var price = pricetoDouble(item.price);
                          var product = Product(item.caption!, price);

                          discountMenu.mainMenu = product;

                          SubItems(
                            header: item.name,
                            submenus: item.subMenus,
                            discountMenu: discountMenu,
                          ).push(context);
                        }

                        if (item.items != null) {
                          ListItem(
                            items: items,
                            header: item.name,
                          ).push(context);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
