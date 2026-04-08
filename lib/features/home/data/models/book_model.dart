class BookModel {
  final int id;
  final String title;
  final String image;
  final String price;
  final String priceAfterDiscount;
  final int discount;
  final bool inWishlist;
  final String description;
  final String category;
  final int stock;

  BookModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.priceAfterDiscount = '',
    this.discount = 0,
    required this.inWishlist,
    this.description = '',
    this.category = '',
    this.stock = 0,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['name'] ?? json['title'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? '0').toString(),
      priceAfterDiscount: (json['price_after_discount'] ?? '').toString(),
      discount: int.tryParse((json['discount'] ?? '0').toString()) ?? 0,
      inWishlist: json['in_wishlist'] ?? false,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      stock: int.tryParse((json['stock'] ?? '0').toString()) ?? 0,
    );
  }
}