import 'dart:async';
import 'package:flutter/material.dart';
import 'global_data.dart';
import 'track_page.dart'; // Ensure this matches your tracking page filename

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Timer? _orderTimer;
  // Note: For a real app, orderHistory should be moved to global_data.dart
  // so it persists when you switch tabs.
  static List<Map<String, dynamic>> orderHistory = [];

  @override
  void initState() {
    super.initState();
    _startOrderSimulation();
  }

  @override
  void dispose() {
    _orderTimer?.cancel();
    super.dispose();
  }

  void _startOrderSimulation() {
    _orderTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (myOrders.isEmpty) return;

      if (mounted) {
        setState(() {
          List<Map<String, dynamic>> completedOrders = [];

          for (var order in myOrders) {
            double currentProgress = (order['progress'] ?? 0.0);

            if (currentProgress < 1.0) {
              // Increment progress
              order['progress'] = (currentProgress + 0.1).clamp(0.0, 1.0);

              // Update Status strings based on progress
              if (order['progress'] >= 1.0) {
                order['status'] = "Delivered";
                completedOrders.add(order);
              } else if (order['progress'] >= 0.7) {
                order['status'] = "Out for Delivery";
              } else if (order['progress'] >= 0.3) {
                order['status'] = "Preparing";
              } else {
                order['status'] = "Order Placed";
              }
            }
          }

          // Move finished orders to history
          for (var order in completedOrders) {
            myOrders.remove(order);
            orderHistory.insert(0, order); // Add to top of history
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "My Orders",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFFF7941D),
            labelColor: Color(0xFFF7941D),
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "Active"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ACTIVE TAB
            myOrders.isEmpty
                ? _buildEmptyState("No active orders right now.")
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: myOrders.length,
                    itemBuilder: (context, index) =>
                        _buildOrderCard(myOrders[index], isActive: true),
                  ),
            // HISTORY TAB
            orderHistory.isEmpty
                ? _buildEmptyState("You haven't placed any orders yet.")
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: orderHistory.length,
                    itemBuilder: (context, index) =>
                        _buildOrderCard(orderHistory[index], isActive: false),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          Text(message, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, {required bool isActive}) {
    double progress = order['progress'] ?? 0.0;
    String status = order['status'] ?? "Pending";
    Color themeColor = isActive ? const Color(0xFFF7941D) : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: isActive
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackOrderPage(order: order),
                    ),
                  );
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        order['title'] ?? "Food Order",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Order ID: #BK${order.hashCode.toString().substring(0, 5)}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isActive
                          ? "Estimated Arrival: 25 mins"
                          : "Delivered on Just Now",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (isActive) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade100,
                      color: themeColor,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tap to track live order",
                        style: TextStyle(
                          color: Color(0xFFF7941D),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: Color(0xFFF7941D),
                      ),
                    ],
                  ),
                ] else
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Logic to add item back to cart
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to cart again!")),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFF7941D)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Order Again",
                        style: TextStyle(color: Color(0xFFF7941D)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
