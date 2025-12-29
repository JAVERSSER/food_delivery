import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartTab extends StatelessWidget {
  final List<CartItem> cartItems;
  final VoidCallback onClearCart;
  final VoidCallback onQuantityChanged;

  const CartTab({
    Key? key,
    required this.cartItems,
    required this.onClearCart,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double subtotal = cartItems.fold(0, (sum, item) => sum + (item.food.price * item.quantity));
    double deliveryFee = 3.99;
    double total = subtotal + deliveryFee;

    return cartItems.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text('Your cart is empty', style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to home tab (handled in parent)
                  },
                  child: const Text('Browse Menu'),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                cartItem.food.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.fastfood, size: 30, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.food.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    cartItem.food.restaurant,
                                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '\$${cartItem.food.price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove, size: 16),
                                        onPressed: () {
                                          if (cartItem.quantity > 1) {
                                            cartItem.quantity--;
                                          } else {
                                            cartItems.removeAt(index);
                                          }
                                          onQuantityChanged();
                                        },
                                        constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                                        padding: EdgeInsets.zero,
                                      ),
                                      Text(
                                        cartItem.quantity.toString(),
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add, size: 16),
                                        onPressed: () {
                                          cartItem.quantity++;
                                          onQuantityChanged();
                                        },
                                        constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () {
                                    cartItems.removeAt(index);
                                    onQuantityChanged();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:'),
                        Text('\$${subtotal.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Fee:'),
                        Text('\$${deliveryFee.toStringAsFixed(2)}'),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Order Placed!'),
                              content: Text('Your order of \$${total.toStringAsFixed(2)} has been placed successfully!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    onClearCart();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}