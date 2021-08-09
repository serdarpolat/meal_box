import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_box/models/Product.dart';

class PriceNotifier extends StateNotifier<double> {
  PriceNotifier() : super(0);

  void incrementPrice(double p) {
    state += p;
  }

  void decrementPrice(double p) {
    if (state >= p) {
      state -= p;
    }
  }
}

final priceProvider =
    StateNotifierProvider<PriceNotifier, double>((ref) => PriceNotifier());

class OrderNotifier extends StateNotifier<List<Product>> {
  OrderNotifier() : super([]);

  addProduct(Product p) {
    state.add(p);
  }

  removeProduct(Product p) {
    state.remove(p);
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, List<Product>>(
    (ref) => OrderNotifier());
