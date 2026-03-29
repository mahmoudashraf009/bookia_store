class BookModel {
  final int id;
  final String title;
  final String image;
  final String price;
  final bool inWishlist;

  BookModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.inWishlist,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'].toString(),
      inWishlist: json['in_wishlist'] ?? false,
    );
  }
}