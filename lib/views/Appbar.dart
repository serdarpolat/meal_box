import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_box/src/providers.dart';
import 'package:meal_box/src/Extensions.dart';
import 'package:meal_box/views/Order.dart';

AppBar appBar() => AppBar(
      backgroundColor: Colors.black,
      brightness: Brightness.dark,
      elevation: 10,
      centerTitle: true,
      title: Image.asset(
        "assets/images/logo.jpg",
        height: 52,
      ),
      actions: [
        Consumer(
          builder: (BuildContext context, watch, Widget? child) {
            bool noPrice = watch(priceProvider) == 0.0;
            return noPrice
                ? Container()
                : MaterialButton(
                    onPressed: () {
                      Order().push(context);
                    },
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    splashColor: Colors.black,
                    color: Color(0xff04e762),
                    child: Text(
                      watch(priceProvider).toStringAsFixed(2) + " TL",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
          },
        ),
      ],
    );
