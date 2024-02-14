import 'package:hive/hive.dart';
part 'Goods.g.dart';

class Goods {
  Goods(
      {required this.name,
      required this.image,
      required this.description,
      required this.price,
      required this.goods});

  final String name;
  final String image;
  final String description;
  final double price;
  final allGoods goods;
}

@HiveType(typeId: 4)
enum allGoods {
  @HiveField(0)
  Shoe,
  @HiveField(1)
  Jacket,
  @HiveField(2)
  Phone,
  @HiveField(3)
  Basket
}

List<Goods> availableGoods = [
  Goods(
      name: "Shoe",
      image: "shoe",
      description: "An old show. Increase your speed",
      price: 2.5,
      goods: allGoods.Shoe),
  Goods(
      name: "Jacket",
      image: "jacket",
      description: "Protect you from the damage",
      price: 5,
      goods: allGoods.Jacket),
  Goods(
      name: "Phone",
      image: "phone",
      description: "You can know where the building is.",
      price: 5,
      goods: allGoods.Phone),
  Goods(
      name: "Basket",
      image: "basket",
      description: "Increase you maximum loading",
      price: 2,
      goods: allGoods.Basket),
];
