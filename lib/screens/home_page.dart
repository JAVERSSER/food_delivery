import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/user.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../data/food_data.dart';
import '../widgets/home_tab.dart';
import '../widgets/cart_tab.dart';
import '../widgets/account_tab.dart';
import '../widgets/nearby_tab.dart';

class HomePage extends StatefulWidget {
  final User currentUser;

  const HomePage({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedCategory = 0;
  String _searchQuery = '';
  String _sortOption = 'none';
  final TextEditingController _searchController = TextEditingController();
  final List<CartItem> _cartItems = [];

  // User profile data
  String _userName = 'John Doe';
  String _userEmail = 'john.doe@email.com';
  String _userPhone = '+1 234 567 8900';
  String _userAddress = '123 Main Street, City, Country';

  List<FoodItem> get filteredFoodItems {
    List<FoodItem> items = FoodData.allFoodItems;

    if (_selectedCategory > 0) {
      String selectedCategoryName =
          FoodData.categories[_selectedCategory]['name'];
      items =
          items.where((item) => item.category == selectedCategoryName).toList();
    }

    if (_searchQuery.isNotEmpty) {
      items = items
          .where((item) =>
              item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.restaurant
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    if (_sortOption == 'price_low') {
      items.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortOption == 'price_high') {
      items.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortOption == 'rating') {
      items.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return items;
  }

  void _toggleFavorite(int index) {
    setState(() {
      filteredFoodItems[index].isFavorite =
          !filteredFoodItems[index].isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          filteredFoodItems[index].isFavorite
              ? '${filteredFoodItems[index].name} added to favorites!'
              : '${filteredFoodItems[index].name} removed from favorites!',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _addToCart(FoodItem item, int quantity) {
    setState(() {
      int existingIndex =
          _cartItems.indexWhere((cartItem) => cartItem.food.name == item.name);
      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity += quantity;
      } else {
        _cartItems.add(CartItem(food: item, quantity: quantity));
      }
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart!'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _updateProfile(String name, String email, String phone, String address) {
    setState(() {
      _userName = name;
      _userEmail = email;
      _userPhone = phone;
      _userAddress = address;
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            HomeTab(
              searchController: _searchController,
              selectedCategory: _selectedCategory,
              sortOption: _sortOption,
              searchQuery: _searchQuery,
              filteredFoodItems: filteredFoodItems,
              onCategorySelected: (index) =>
                  setState(() => _selectedCategory = index),
              onSearchChanged: (value) => setState(() => _searchQuery = value),
              onSortChanged: (option) => setState(() => _sortOption = option),
              onToggleFavorite: _toggleFavorite,
              onAddToCart: _addToCart,
            ),
            const NearByTab(),
            CartTab(
              cartItems: _cartItems,
              onClearCart: _clearCart,
              onQuantityChanged: () => setState(() {}),
            ),
            AccountTab(
              userName: _userName,
              userEmail: _userEmail,
              userPhone: _userPhone,
              userAddress: _userAddress,
              currentUser: widget.currentUser, // ✅ correct
              onUpdateProfile: _updateProfile,
              onLogout: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.near_me), label: 'Near By'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (_cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        _cartItems.length.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
