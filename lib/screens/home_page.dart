import 'package:flutter/material.dart';
import 'global_data.dart';
import 'meal_card.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const Color primaryOrange = Color(0xFFFF6B00);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";

  // Data for the meal cards
  final List<Map<String, dynamic>> allMealData = [
    {
      "title": "Ultimate Breakfast",
      "vendor": "Nanay's Kitchen",
      "price": 150,
      "left": 20,
      "type": "Breakfast",
    },
    {
      "title": "Lunch Value Pack",
      "vendor": "Nanay's Kitchen",
      "price": 350,
      "left": 15,
      "type": "Lunch",
    },
    {
      "title": "Puto & Kutsinta",
      "vendor": "Aling Nena",
      "price": 120,
      "left": 10,
      "type": "Merienda",
    },
    {
      "title": "Family Dinner Set",
      "vendor": "Kusina Express",
      "price": 500,
      "left": 5,
      "type": "Dinner",
    },
  ];

  void refreshBadge() {
    setState(() {
      cartCount = myOrders.fold(
        0,
        (sum, item) => sum + (item['quantity'] as int),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildCategoryRow(),
                        const SizedBox(height: 25),
                        Text(
                          selectedCategory == "All"
                              ? "Available Packages"
                              : "$selectedCategory Packages",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildMealList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF4D00), Color(0xFFFF8A00)],
        ),
      ),
      child: Row(
        children: [
          const Text(
            "BahayKusina",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          _buildCartBadge(),
          const SizedBox(width: 15),
          const Icon(Icons.notifications_none, color: Colors.white, size: 28),
        ],
      ),
    );
  }

  Widget _buildCartBadge() {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartPage()),
        );
        refreshBadge();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
            size: 26,
          ),
          if (cartCount > 0)
            Positioned(
              right: -5,
              top: -5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '$cartCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow() {
    List<String> categories = [
      "All",
      "Breakfast",
      "Lunch",
      "Dinner",
      "Merienda",
    ];
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, i) {
          bool isSelected = selectedCategory == categories[i];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[i]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? HomePage.primaryOrange : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? HomePage.primaryOrange
                      : Colors.grey.shade300,
                ),
              ),
              child: Center(
                child: Text(
                  categories[i],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealList() {
    final filteredMeals = allMealData
        .where(
          (meal) =>
              selectedCategory == "All" || meal["type"] == selectedCategory,
        )
        .toList();

    return Column(
      children: filteredMeals.map((meal) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: MealCard(
            title: meal["title"],
            vendor: meal["vendor"],
            price: meal["price"].toDouble(),
            left: meal["left"],
            type: meal["type"],
            onOrder: refreshBadge,
          ),
        );
      }).toList(),
    );
  }
}
