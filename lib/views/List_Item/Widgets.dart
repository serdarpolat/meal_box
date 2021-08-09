import 'package:flutter/material.dart';
import 'package:meal_box/models/Item.dart';

Widget price(dynamic price) => Align(
      alignment: Alignment(0.9, -0.85),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Text(
          price.toString() + " TL",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[50],
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xff0aff99),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );

Widget productItem(Item item, String img) => Column(
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            width: double.infinity,
            child: item.price != null
                ? Align(
                    alignment: Alignment(0.9, -0.85),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      child: Text(
                        item.price.toString() + " TL",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[50],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffc00d11),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  )
                : Container(),
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
            child: Center(
              child: Text(
                item.name.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
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
    );

class ProductItem extends StatelessWidget {
  final Item? item;
  final String? img;
  final Function()? onPressed;
  const ProductItem({Key? key, this.item, this.img, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(0),
      child: productItem(item!, img!),
    );
  }
}
