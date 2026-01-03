class MealPackage {
  String name;
  String category;
  String description;
  String price;
  String stock;
  int itemsCount;

  MealPackage({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
    this.itemsCount = 4,
  });
}
