import 'package:flutter/material.dart';
import 'global_data.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const Color primaryOrange = Colors.orange;
  static const Color accentRed = Colors.redAccent;

  // FIX: Added null-safety checks to prevent the 'Null' type error
  double calculateSubtotal() {
    return myOrders.fold(0.0, (sum, item) {
      double price = (item['price'] ?? 0.0).toDouble();
      int quantity = (item['quantity'] ?? 1);
      return sum + (price * quantity);
    });
  }

  void _updateState() {
    setState(() {
      cartCount = myOrders.fold(
        0,
        (sum, item) => sum + (item['quantity'] as int? ?? 0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = calculateSubtotal();
    double deliveryFee = subtotal > 0 ? 5.0 : 0.0;
    double total = subtotal + deliveryFee;

    return Scaffold(
      // Gradient Header Area
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryOrange, accentRed],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.3], // Keeps gradient at the top
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5), // Light grey body
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: myOrders.isEmpty
                      ? const Center(child: Text("Your food cart is empty!"))
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(20),
                                itemCount: myOrders.length,
                                itemBuilder: (context, index) {
                                  final item = myOrders[index];
                                  return _buildCartItem(item, index);
                                },
                              ),
                            ),
                            _buildBottomSummary(subtotal, deliveryFee, total),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            "Food Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Changed to Food Cart Icon
          Stack(
            children: [
              const Icon(
                Icons.fastfood_outlined,
                color: Colors.white,
                size: 28,
              ),
              if (cartCount > 0)
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.white,
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.restaurant, color: Colors.grey),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? "Food Item",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "Freshly prepared",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  "₱${(item['price'] ?? 0.0).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryOrange,
                  ),
                ),
              ],
            ),
          ),
          // Clean Qty Controls like the image
          Row(
            children: [
              _qtyActionBtn(Icons.remove, () {
                if ((item['quantity'] ?? 1) > 1) {
                  item['quantity']--;
                } else {
                  myOrders.removeAt(index);
                }
                _updateState();
              }, false),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${item['quantity'] ?? 1}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _qtyActionBtn(Icons.add, () {
                item['quantity'] = (item['quantity'] ?? 0) + 1;
                _updateState();
              }, true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyActionBtn(IconData icon, VoidCallback onTap, bool isAdd) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isAdd ? primaryOrange : Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isAdd ? Colors.white : Colors.black54,
        ),
      ),
    );
  }

  Widget _buildBottomSummary(double subtotal, double delivery, double total) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                "₱${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(totalAmount: total),
                ),
              ),
              child: const Text(
                "PROCEED TO CHECKOUT",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
