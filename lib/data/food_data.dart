import '../models/food_item.dart';

class FoodData {
  static final List<FoodItem> allFoodItems = [
    FoodItem(
      name: 'Fried Egg Breakfast',
      image: 'assets/images/breakfast/fried_egg.png',
      price: 15.06,
      rating: 4.9,
      reviews: 200,
      restaurant: 'Breakfast Corner',
      category: 'Breakfast',
      description:
          'Delicious fried eggs with bacon, toast, fresh vegetables and special sauce. Perfect way to start your day with protein and energy.',
    ),
    FoodItem(
      name: 'Classic Burger',
      image: 'assets/images/burgers/classic_burger.png',
      price: 12.99,
      rating: 4.7,
      reviews: 180,
      restaurant: 'Burger House',
      category: 'Burger',
      description:
          'Juicy beef patty with fresh lettuce, tomatoes, cheese, and our special sauce on a toasted bun.',
    ),
    FoodItem(
      name: 'Mixed Vegetable Bowl',
      image: 'assets/images/salads/mixed_vegetable.png',
      price: 17.03,
      rating: 4.9,
      reviews: 100,
      restaurant: 'Green Garden',
      category: 'Salad',
      description:
          'Fresh mixed vegetables sautéed to perfection with aromatic herbs and spices. Healthy and delicious.',
    ),
    FoodItem(
      name: 'Salmon Sushi Roll',
      image: 'assets/images/sushi/salmon_roll.png',
      price: 18.50,
      rating: 4.8,
      reviews: 156,
      restaurant: 'Tokyo Sushi',
      category: 'Sushi',
      description:
          'Fresh salmon sushi roll with avocado, cucumber, and special wasabi mayo. Made with premium ingredients.',
    ),
    FoodItem(
      name: 'Margherita Pizza',
      image: 'assets/images/pizza/margherita.png',
      price: 14.99,
      rating: 4.6,
      reviews: 220,
      restaurant: 'Italian Kitchen',
      category: 'Pizza',
      description:
          'Classic Italian pizza with fresh mozzarella, tomatoes, and basil on thin crispy crust.',
    ),
    FoodItem(
      name: 'Garden Fresh Salad',
      image: 'assets/images/salads/garden_salad.png',
      price: 11.10,
      rating: 4.00,
      reviews: 100,
      restaurant: 'Healthy Bites',
      category: 'Salad',
      description:
          'A delicious combination of fresh greens, cherry tomatoes, cucumbers, and house vinaigrette dressing.',
    ),
    FoodItem(
      name: 'Chocolate Cake',
      image: 'assets/images/cakes/chocolate_cake.png',
      price: 8.99,
      rating: 4.9,
      reviews: 340,
      restaurant: 'Sweet Dreams',
      category: 'Cake',
      description:
          'Rich chocolate cake with creamy chocolate frosting. Perfect for dessert lovers.',
    ),
    FoodItem(
      name: 'Vanilla Ice Cream',
      image: 'assets/images/ice_cream/vanilla.png',
      price: 6.50,
      rating: 4.7,
      reviews: 280,
      restaurant: 'Ice Cream Palace',
      category: 'Ice Cream',
      description:
          'Creamy vanilla ice cream made with real vanilla beans. Topped with chocolate sauce.',
    ),
    FoodItem(
      name: 'BBQ Burger Deluxe',
      image: 'assets/images/burgers/bbq_burger.png',
      price: 16.50,
      rating: 4.8,
      reviews: 195,
      restaurant: 'Burger House',
      category: 'Burger',
      description:
          'Double beef patty with BBQ sauce, bacon, onion rings, and cheddar cheese.',
    ),
    FoodItem(
      name: 'Caesar Salad',
      image: 'assets/images/salads/caesar_salad.png',
      price: 12.00,
      rating: 4.5,
      reviews: 150,
      restaurant: 'Healthy Bites',
      category: 'Salad',
      description:
          'Classic Caesar salad with romaine lettuce, parmesan cheese, croutons and Caesar dressing.',
    ),
    FoodItem(
      name: 'Strawberry Cake',
      image: 'assets/images/cakes/strawberry_cake.png',
      price: 9.99,
      rating: 4.8,
      reviews: 210,
      restaurant: 'Sweet Dreams',
      category: 'Cake',
      description:
          'Light and fluffy strawberry cake with fresh strawberries and whipped cream.',
    ),
    FoodItem(
      name: 'Spicy Tuna Roll',
      image: 'assets/images/sushi/spicy_tuna.png',
      price: 16.00,
      rating: 4.7,
      reviews: 145,
      restaurant: 'Tokyo Sushi',
      category: 'Sushi',
      description:
          'Spicy tuna with cucumber and spicy mayo, topped with sesame seeds.',
    ),
  ];

  static final List<Map<String, dynamic>> categories = [
    {'name': 'All', 'icon': '🍽️'},
    {'name': 'Burger', 'icon': '🍔'},
    {'name': 'Sushi', 'icon': '🍱'},
    {'name': 'Pizza', 'icon': '🍕'},
    {'name': 'Cake', 'icon': '🎂'},
    {'name': 'Ice Cream', 'icon': '🍦'},
    {'name': 'Salad', 'icon': '🥗'},
    {'name': 'Breakfast', 'icon': '🍳'},
  ];

  static final List<Map<String, String>> restaurants = [
    {
      'name': 'Breakfast Corner',
      'cuisine': 'American, Breakfast',
      'distance': '0.5 km',
      'rating': '4.9',
      'image': 'assets/images/restaurants/breakfast_corner.png',
    },
    {
      'name': 'Burger House',
      'cuisine': 'Fast Food, Burgers',
      'distance': '1.2 km',
      'rating': '4.7',
      'image': 'assets/images/restaurants/burger_house.png',
    },
    {
      'name': 'Tokyo Sushi',
      'cuisine': 'Japanese, Sushi',
      'distance': '2.0 km',
      'rating': '4.8',
      'image': 'assets/images/restaurants/tokyo_sushi.png',
    },
    {
      'name': 'Italian Kitchen',
      'cuisine': 'Italian, Pizza',
      'distance': '1.5 km',
      'rating': '4.6',
      'image': 'assets/images/restaurants/italian_kitchen.png',
    },
    {
      'name': 'Green Garden',
      'cuisine': 'Healthy, Salads',
      'distance': '0.8 km',
      'rating': '4.9',
      'image': 'assets/images/restaurants/green_garden.png',
    },
    {
      'name': 'Sweet Dreams',
      'cuisine': 'Desserts, Cakes',
      'distance': '1.8 km',
      'rating': '4.8',
      'image': 'assets/images/restaurants/sweet_dreams.png',
    },
  ];
}