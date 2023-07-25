class Product {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double amount;
  bool isfav;

  Product(
      {required this.isfav,
      required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.amount});
}
