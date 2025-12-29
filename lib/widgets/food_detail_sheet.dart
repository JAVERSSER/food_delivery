import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodDetailSheet extends StatefulWidget {
  final FoodItem item;
  final Function(FoodItem, int) onAddToCart;

  const FoodDetailSheet({
    Key? key,
    required this.item,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  State<FoodDetailSheet> createState() => _FoodDetailSheetState();
}

class _FoodDetailSheetState extends State<FoodDetailSheet> {
  int quantity = 1;
  bool showDetails = true;

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String name, int rating, String review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            size: 14,
                            color: index < rating ? Colors.orange : Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(review, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        widget.item.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.item.isFavorite = !widget.item.isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            widget.item.image,
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 250,
                                width: 250,
                                color: Colors.grey[300],
                                child: const Icon(Icons.fastfood, size: 80, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.item.name,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '\$${widget.item.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'by ${widget.item.restaurant}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.orange),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.item.rating} (${widget.item.reviews} reviews)',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildInfoChip(Icons.access_time, '12m-4pm', Colors.blue),
                                  const SizedBox(width: 12),
                                  _buildInfoChip(Icons.location_on, '3.3 km', Colors.green),
                                  const SizedBox(width: 12),
                                  _buildInfoChip(Icons.map, 'Map View', Colors.pink),
                                  const SizedBox(width: 12),
                                  _buildInfoChip(Icons.delivery_dining, 'Delivery', Colors.red),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      showDetails = true;
                                    });
                                  },
                                  child: Text(
                                    'Food Details',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: showDetails ? FontWeight.bold : FontWeight.normal,
                                      color: showDetails ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      showDetails = false;
                                    });
                                  },
                                  child: Text(
                                    'Food Reviews',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: !showDetails ? FontWeight.bold : FontWeight.normal,
                                      color: !showDetails ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (showDetails)
                              Text(
                                widget.item.description,
                                style: TextStyle(color: Colors.grey[700], height: 1.5, fontSize: 14),
                              )
                            else
                              Column(
                                children: [
                                  _buildReviewCard('Sarah Johnson', 5, 'Amazing food! Fresh and delicious.'),
                                  _buildReviewCard('Mike Chen', 4, 'Great taste, but took a while to arrive.'),
                                  _buildReviewCard('Emma Wilson', 5, 'Best food delivery experience ever!'),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onAddToCart(widget.item, quantity);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Add To Bag • \$${(widget.item.price * quantity).toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}