import 'package:meal_box/models/Product.dart';

class DiscountMenu {
  Product? mainMenu;
  Product? mainCourse;
  Product? firstStarter;
  Product? secondStarter;

  DiscountMenu(
    this.mainMenu,
    this.mainCourse,
    this.firstStarter,
    this.secondStarter,
  );
}
