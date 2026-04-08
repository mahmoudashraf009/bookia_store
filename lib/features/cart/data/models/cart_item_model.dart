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
    // Determine the book json structure. The API returns it flattened with 'item_product_' prefix
    Map<String, dynamic>? bookJson = json['product'] ?? json['book'] ?? json['item'];
    
    if (bookJson == null) {
      if (json.containsKey('item_product_id')) {
         bookJson = {
            'id': json['item_product_id'],
            'name': json['item_product_name'],
            'image': json['item_product_image'],
            'price': json['item_product_price'],
            'discount': json['item_product_discount'],
            'price_after_discount': json['item_product_price_after_discount'],
            'stock': json['item_product_stock'],
         };
      } else {
         bookJson = json; // fallback
      }
    }
    
    return CartItemModel(
      id: json['item_id'] ?? json['cart_item_id'] ?? json['id'] ?? 0,
      quantity: int.tryParse((json['item_quantity'] ?? json['quantity'] ?? '1').toString()) ?? 1,
      total: double.tryParse((json['item_total'] ?? json['total'] ?? json['price'] ?? 0).toString()) ?? 0.0,
      book: BookModel.fromJson(bookJson),
    );
  }
}
