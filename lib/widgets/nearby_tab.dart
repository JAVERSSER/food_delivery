import 'package:flutter/material.dart';
import '../data/food_data.dart';

class NearByTab extends StatelessWidget {
  const NearByTab({Key? key}) : super(key: key);

  Widget _buildRestaurantCard(Map<String, String> restaurant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              restaurant['image']!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: const Icon(Icons.restaurant, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant['name']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(restaurant['rating']!),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(restaurant['cuisine']!, style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(restaurant['distance']!, style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('20-30 min', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Restaurants Near You',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...FoodData.restaurants.map((restaurant) => _buildRestaurantCard(restaurant)).toList(),
      ],
    );
  }
} 