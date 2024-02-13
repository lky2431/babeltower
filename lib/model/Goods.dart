class Goods {
  Goods(
      {required this.name,
      required this.image,
      required this.description,
      required this.price});

  final String name;
  final String image;
  final String description;
  final double price;
}

enum allGoods { Shoe, Jacket, Phone, Basket }

List<Goods> availableGoods = [
  Goods(
      name: "Shoe",
      image: "shoe",
      description: "An old show. Increase your speed",
      price: 2.5),
  Goods(
      name: "Jacket",
      image: "jacket",
      description: "Protect you from the damage",
      price: 5),
  Goods(
      name: "Phone",
      image: "phone",
      description: "You can know where the building is.",
      price: 5),
  Goods(
      name: "Basket",
      image: "basket",
      description: "Increase you maximum loading",
      price: 2),
];
