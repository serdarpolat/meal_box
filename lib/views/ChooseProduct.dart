import 'package:flutter/material.dart';
import 'package:meal_box/models/DiscountMenu.dart';
import 'package:meal_box/models/Item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_box/models/Product.dart';
import 'package:meal_box/src/Extensions.dart';
import 'package:meal_box/src/providers.dart';

class ChooseProduct extends StatelessWidget {
  final String header;
  final List<Item> items;
  final int subItemIndex;
  final DiscountMenu discountMenu;
  const ChooseProduct({
    Key? key,
    required this.header,
    required this.items,
    required this.discountMenu,
    required this.subItemIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        elevation: 10,
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo.jpg",
          height: 52,
        ),
      ),
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
                header,
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
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 0,
                  childAspectRatio: 3.75 / 4,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  children: List.generate(items.length, (idx) {
                    Item item = items[idx];
                    var img = item.image;
                    img = img!.replaceFirst(".", "assets");
                    var prc = item.price == null ? 0.0 : item.price;
                    var prcStr =
                        prc == null ? "0.0 TL" : "+" + prc.toString() + " TL";

                    return MaterialButton(
                      onPressed: () {
                        Product prod = Product(item.name!, pricetoDouble(prc));

                        if (subItemIndex == 0) {
                          discountMenu.mainCourse = prod;

                          context
                              .read(orderProvider.notifier)
                              .addProduct(discountMenu.mainMenu!);

                          context.read(orderProvider.notifier).addProduct(prod);

                          context.read(priceProvider.notifier).incrementPrice(
                              discountMenu.mainMenu!.price +
                                  pricetoDouble(prc));

                          Navigator.pop(context);
                        } else if (subItemIndex == 1) {
                          discountMenu.firstStarter = prod;

                          context
                              .read(orderProvider.notifier)
                              .addProduct(discountMenu.firstStarter!);

                          context
                              .read(priceProvider.notifier)
                              .incrementPrice(pricetoDouble(prc));

                          Navigator.pop(context);
                        } else if (subItemIndex == 2) {
                          discountMenu.secondStarter = prod;

                          context
                              .read(orderProvider.notifier)
                              .addProduct(discountMenu.secondStarter!);

                          context
                              .read(priceProvider.notifier)
                              .incrementPrice(pricetoDouble(prc));

                          Navigator.pop(context);
                        } else {
                          context.read(orderProvider.notifier).addProduct(prod);

                          context
                              .read(priceProvider.notifier)
                              .incrementPrice(pricetoDouble(prc));

                          Navigator.pop(context);
                        }
                      },
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Container(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment(0.9, -0.85),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: Text(
                                    prcStr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[50],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffc00d11),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(img),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: Text(
                                  item.name.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 0),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
