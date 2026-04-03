class BookModel {
  final int id;
  final String title;
  final String image;
  final String price;
  final bool inWishlist;
  final String description;
  final String category;

  BookModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.inWishlist,
    this.description = '',
    this.category = '',
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      price: json['price'].toString(),
      inWishlist: json['in_wishlist'] ?? false,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }
}