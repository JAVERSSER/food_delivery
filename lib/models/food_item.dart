class FoodItem {
  final String name;
  final String image;
  final double price;
  final double rating;
  final int reviews;
  final String restaurant;
  final String description;
  final String category;
  bool isFavorite;

  FoodItem({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.restaurant,
    required this.description,
    required this.category,
    this.isFavorite = false,
  });
}