import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../data/food_data.dart';
import 'food_detail_sheet.dart';

class HomeTab extends StatelessWidget {
  final TextEditingController searchController;
  final int selectedCategory;
  final String sortOption;
  final String searchQuery;
  final List<FoodItem> filteredFoodItems;
  final Function(int) onCategorySelected;
  final Function(String) onSearchChanged;
  final Function(String) onSortChanged;
  final Function(int) onToggleFavorite;
  final Function(FoodItem, int) onAddToCart;

  const HomeTab({
    Key? key,
    required this.searchController,
    required this.selectedCategory,
    required this.sortOption,
    required this.searchQuery,
    required this.filteredFoodItems,
    required this.onCategorySelected,
    required this.onSearchChanged,
    required this.onSortChanged,
    required this.onToggleFavorite,
    required this.onAddToCart,
  }) : super(key: key);

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filter Options', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildFilterOption(context, 'Sort by Price: Low to High', Icons.sort, 'price_low'),
              _buildFilterOption(context, 'Sort by Price: High to Low', Icons.sort, 'price_high'),
              _buildFilterOption(context, 'Sort by Rating', Icons.star, 'rating'),
              _buildFilterOption(context, 'Clear Sorting', Icons.clear, 'none'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(BuildContext context, String title, IconData icon, String option) {
    return ListTile(
      leading: Icon(icon, color: option == 'rating' ? Colors.orange : Colors.red),
      title: Text(title),
      trailing: sortOption == option ? const Icon(Icons.check, color: Colors.red) : null,
      onTap: () {
        onSortChanged(option);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sorted: $title')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'What would you like to eat?',
                  style: TextStyle(fontSize: screenWidth > 600 ? 22 : 18, fontWeight: FontWeight.w500),
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No new notifications')),
                      );
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'What would you like to buy?',
              prefixIcon: const Icon(Icons.search, color: Colors.red),
              suffixIcon: IconButton(
                icon: const Icon(Icons.tune, color: Colors.red),
                onPressed: () => _showFilterOptions(context),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: FoodData.categories.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedCategory == index;
              return GestureDetector(
                onTap: () => onCategorySelected(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.red : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(FoodData.categories[index]['icon'], style: const TextStyle(fontSize: 32)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        FoodData.categories[index]['name'],
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.red : Colors.grey[700],
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: filteredFoodItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('No food items found', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredFoodItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredFoodItems[index];
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => FoodDetailSheet(item: item, onAddToCart: onAddToCart),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.asset(
                                    item.image,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 120,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.fastfood, size: 50, color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () => onToggleFavorite(index),
                                    child: Container(
                                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                      padding: const EdgeInsets.all(4),
                                      child: Icon(
                                        item.isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(Icons.location_on, size: 16, color: Colors.red),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(item.rating.toString(), style: const TextStyle(fontSize: 12)),
                                      const SizedBox(width: 4),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (i) => Icon(
                                            Icons.star,
                                            size: 12,
                                            color: i < item.rating.floor() ? Colors.orange : Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text('(${item.reviews})', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text('\$${item.price.toStringAsFixed(2)}', 
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}