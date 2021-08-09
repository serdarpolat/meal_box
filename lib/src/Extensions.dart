import 'package:flutter/material.dart';

extension Routing on Widget {
  push(BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => this));
  }
}

double pricetoDouble(dynamic p) {
  return p.toString().contains(",")
      ? double.parse(p.replaceFirst(",", "."))
      : p.toDouble();
}
