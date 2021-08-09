import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_box/models/Product.dart';
import 'package:meal_box/src/providers.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

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
      body: Consumer(
        builder: (context, watch, Widget? child) {
          List<Product> order = watch(orderProvider);
          var total = 0.0;

          for (var o in order) {
            total += o.price;
          }

          return Container(
              width: s.width,
              height: s.height,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: s.width,
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Order",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: List.generate(order.length, (index) {
                            var item = order[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                tileColor: Colors.grey[300],
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child: Text(
                                    item.price.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff04e762),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: s.width,
                      height: 64,
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TOPLAM",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: Text(
                              total.toStringAsFixed(2) + " TL",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff04e762),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
