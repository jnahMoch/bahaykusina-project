import 'package:bahay_kusina/vendor/data_model.dart';
import 'package:flutter/material.dart';
import 'add_package_page.dart';
import 'vendor_profile_page.dart';

class VendorHomePage extends StatefulWidget {
  const VendorHomePage({super.key});

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  static const Color primaryOrange = Color(0xFFFF5722);
  static const Color secondaryOrange = Color(0xFFFF8A50);
  static const Color bgColor = Color(0xFFFBFBFB);

  bool isShowingOrders = false;

  List<MealPackage> packages = [
    MealPackage(
      name: "Ultimate Breakfast Package",
      category: "Breakfast",
      description:
          "Start your day right with a hearty Filipino breakfast including garlic rice and egg.",
      price: "150",
      stock: "20",
    ),
    MealPackage(
      name: "Lunch Value Pack",
      category: "Lunch",
      description: "Complete lunch meal for the whole family.",
      price: "350",
      stock: "15",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            // RESTORED ALL STATS HERE
            _buildStatsGrid(),
            const SizedBox(height: 20),
            _buildTabToggle(),
            isShowingOrders ? _buildOrdersSection() : _buildPackagesSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [primaryOrange, secondaryOrange]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vendor Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Nanay's Kitchen",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VendorProfilePage(),
              ),
            ),
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Restored: 4 Stats in a clean, scrollable or wrapped row
  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              _statCard("Total Packages", "${packages.length}"),
              _statCard("Total Orders", "2"),
            ],
          ),
          Row(
            children: [
              _statCard("Total Revenue", "₱650"),
              _statCard("Avg. Order", "₱325"), // RESTORED
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabToggle() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _toggleButton("Manage Packages", !isShowingOrders),
            _toggleButton("Orders", isShowingOrders),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String text, bool isActive) {
    return GestureDetector(
      onTap: () => setState(() => isShowingOrders = (text == "Orders")),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPackagesSection() {
    return Column(
      children: [
        _buildSectionHeader("Meal Packages"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(packages.length, (index) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 20,
                child: _buildPackageCard(packages[index], index),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildPackageCard(MealPackage pkg, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjusts height exactly to text
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Container(
              height: 90,
              width: double.infinity,
              color: const Color(0xFFF5F5F5),
              child: const Icon(Icons.fastfood, color: Colors.grey, size: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pkg.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    pkg.category,
                    style: const TextStyle(
                      fontSize: 9,
                      color: primaryOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // DESCRIPTION IS INTACT
                Text(
                  pkg.description,
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                _infoRow("Price", "₱${pkg.price}", true),
                _infoRow("Stock", "${pkg.stock} left", false),
                _infoRow("Items", "4 items", false), // Info from your image
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _actionBtn(
                        "Edit",
                        () => _handleEdit(pkg, index),
                        Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: _actionBtn(
                        "Delete",
                        () => setState(() => packages.removeAt(index)),
                        Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(String label, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, bool isBold) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? primaryOrange : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPackagePage()),
              );
              if (result != null) setState(() => packages.add(result));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _handleEdit(MealPackage pkg, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPackagePage(existingPackage: pkg),
      ),
    );
    if (result != null) setState(() => packages[index] = result);
  }

  Widget _buildOrdersSection() => const Center(child: Text("No Orders"));
}
