import '../../../home/data/models/book_model.dart';

class CartItemModel {
  final int id; // The ID of the item row in the cart
  final int quantity;
  final double total;
  final BookModel book;

  CartItemModel({
    required this.id,
    required this.quantity,
    required this.total,
    required this.book,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    // Fallback to the root json if the book info is flat (not nested in 'product')
    final bookJson = json['product'] ?? json['book'] ?? json['item'] ?? json;
    
    return CartItemModel(
      id: json['cart_item_id'] ?? json['item_id'] ?? json['id'] ?? 0,
      quantity: int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
      total: double.tryParse((json['item_total'] ?? json['total'] ?? json['price'] ?? 0).toString()) ?? 0.0,
      book: BookModel.fromJson(bookJson),
    );
  }
}
