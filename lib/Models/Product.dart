class Product {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isfav;

  Product(
      {this.isfav = false,
      required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price});
}
