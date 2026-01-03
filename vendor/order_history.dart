import 'package:flutter/material.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  static const Color primaryOrange = Color(0xFFFF5722);

  // Mock data for History (Usually orders that are already Delivered/Cancelled)
  final List<Map<String, dynamic>> pastOrders = [
    {
      "orderNo": "o2",
      "customer": "Juan Dela Cruz",
      "date": "Nov 19, 2025",
      "total": "350",
      "status": "delivered",
      "item": "Lunch Value Pack x 1",
    },
    {
      "orderNo": "o10",
      "customer": "Maria Clara",
      "date": "Nov 15, 2025",
      "total": "150",
      "status": "cancelled",
      "item": "Ultimate Breakfast x 1",
    },
    {
      "orderNo": "o08",
      "customer": "Jose Rizal",
      "date": "Nov 10, 2025",
      "total": "700",
      "status": "delivered",
      "item": "Ultimate Breakfast x 4",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Order History",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search order ID or name...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: pastOrders.length,
              itemBuilder: (context, index) {
                return _buildHistoryCard(pastOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> order) {
    bool isDelivered = order['status'] == "delivered";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          // Small Status Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDelivered
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDelivered ? Icons.check_circle_outline : Icons.cancel_outlined,
              color: isDelivered ? Colors.green : Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),

          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #${order['orderNo']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "₱${order['total']}",
                      style: const TextStyle(
                        color: primaryOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  order['customer'],
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  order['item'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Date and Arrow
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                order['date'],
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
