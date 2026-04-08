
class OrderModel {
  final int id;
  final String status;
  final String total;
  final String date;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.total,
    required this.date,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> items = [];
    if (json['order_details'] != null) {
      items = (json['order_details'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList();
    } else if (json['products'] != null) {
      items = (json['products'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList();
    } else if (json['items'] != null) {
      items = (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList();
    }

    return OrderModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? 'pending',
      total: (json['total'] ?? json['order_total'] ?? '0').toString(),
      date: json['created_at'] ?? json['date'] ?? '',
      items: items,
    );
  }
}

class OrderItemModel {
  final int id;
  final String title;
  final String image;
  final String price;
  final int quantity;
  final String total;

  OrderItemModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
    required this.total,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? json['book'] ?? json;
    return OrderItemModel(
      id: product['id'] ?? json['id'] ?? 0,
      title: product['title'] ?? product['name'] ?? '',
      image: product['image'] ?? '',
      price: (json['price'] ?? product['price'] ?? '0').toString(),
      quantity: int.tryParse((json['quantity'] ?? '1').toString()) ?? 1,
      total: (json['total'] ?? json['item_total'] ?? '0').toString(),
    );
  }
}
