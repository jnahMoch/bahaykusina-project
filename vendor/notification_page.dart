import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  static const Color primaryOrange = Color(0xFFFF5722);

  // Mock data for notifications
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "New Order Received!",
      "message": "You have a new order #o3 from Maria Santos. Check it now.",
      "time": "2 mins ago",
      "type": "order",
      "isRead": false,
    },
    {
      "title": "Payment Confirmed",
      "message": "GCash payment for Order #o2 has been verified successfully.",
      "time": "1 hour ago",
      "type": "payment",
      "isRead": false,
    },
    {
      "title": "System Update",
      "message": "Bahay Kusina will undergo maintenance at 12:00 AM tonight.",
      "time": "5 hours ago",
      "type": "system",
      "isRead": true,
    },
    {
      "title": "Stock Alert",
      "message": "Your 'Lunch Value Pack' is running low (only 2 left).",
      "time": "Yesterday",
      "type": "alert",
      "isRead": true,
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
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var n in notifications) {
                  n['isRead'] = true;
                }
              });
            },
            child: const Text(
              "Clear All",
              style: TextStyle(
                color: primaryOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationItem(notifications[index]);
              },
            ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> item) {
    bool isRead = item['isRead'];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: isRead
            ? Colors.white
            : const Color(0xFFFFF3E0), // Light orange tint for unread
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _getIconColor(item['type']).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getIcon(item['type']),
            color: _getIconColor(item['type']),
            size: 24,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item['title'],
              style: TextStyle(
                fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                fontSize: 15,
              ),
            ),
            if (!isRead)
              const CircleAvatar(radius: 4, backgroundColor: primaryOrange),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              item['message'],
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['time'],
              style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
            ),
          ],
        ),
        onTap: () {
          setState(() => item['isRead'] = true);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 15),
          const Text(
            "No notifications yet",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag_outlined;
      case 'payment':
        return Icons.account_balance_wallet_outlined;
      case 'alert':
        return Icons.error_outline;
      default:
        return Icons.info_outline;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'order':
        return Colors.blue;
      case 'payment':
        return Colors.green;
      case 'alert':
        return Colors.red;
      default:
        return primaryOrange;
    }
  }
}
