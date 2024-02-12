import 'package:flame/components.dart';

import '../tool/cVectors.dart';

List<Trash> availableTrashs = [
  Trash(weight: 1.5, name: "wood", price: 0.3, description: "A mouldy wood", size: v64),
  Trash(weight: 3, name: "bag", price: 0.5, description:  "A bag of trash", size: v96),
  Trash(weight: 1, name: "bottle", price: 0.2, description:  "A beer bottle. No beer inside.", size: v64),
  Trash(weight: 0.7, name: "can", price: 0.2, description:  "A coke can.", size: v48),
];

class Trash {
  Trash({required this.weight, required this.name, required this.price, required this.description, required this.size});

  final String name;
  final double price;
  final double weight;
  final String description;
  final Vector2 size;
}
