import 'cart_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  onTheWay,
  delivered,
  cancelled
}

class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DateTime orderDate;
  OrderStatus status;
  final String deliveryAddress;
  final String customerName;
  final String customerPhone;

  Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.orderDate,
    this.status = OrderStatus.pending,
    required this.deliveryAddress,
    required this.customerName,
    required this.customerPhone,
  });

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending Payment';
      case OrderStatus.confirmed:
        return 'Order Confirmed';
      case OrderStatus.preparing:
        return 'Preparing Your Food';
      case OrderStatus.onTheWay:
        return 'On The Way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get statusIcon {
    switch (status) {
      case OrderStatus.pending:
        return '⏳';
      case OrderStatus.confirmed:
        return '✅';
      case OrderStatus.preparing:
        return '👨‍🍳';
      case OrderStatus.onTheWay:
        return '🚗';
      case OrderStatus.delivered:
        return '📦';
      case OrderStatus.cancelled:
        return '❌';
    }
  }
}