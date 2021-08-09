class Item {
  Item({
    this.name,
    this.caption,
    this.image,
    this.items,
    this.price,
    this.subMenus,
  });

  String? name;
  String? caption;
  String? image;
  List<Item>? items;
  dynamic price;
  List<String>? subMenus;

  factory Item.fromJson(Map<dynamic, dynamic> json) => Item(
        name: json["name"] == null ? null : json["name"],
        caption: json["caption"] == null ? null : json["caption"],
        image: json["image"] == null ? null : json["image"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        price: json["price"],
        subMenus: json["subMenus"] == null
            ? null
            : List<String>.from(json["subMenus"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "caption": caption,
        "image": image,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "price": price,
        "subMenus": subMenus == null
            ? null
            : List<dynamic>.from(subMenus!.map((x) => x)),
      };
}
