import 'package:flutter/material.dart';

class TrackOrderPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const TrackOrderPage({super.key, required this.order});

  static const Color primaryPurple = Color(0xFF7B11FF);

  @override
  Widget build(BuildContext context) {
    // Get the status from the order data passed from OrdersPage
    String currentStatus = order['status'] ?? 'Order Placed';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Track Order",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderIdSection(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Timeline",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            // Pass the current status to the timeline builder
            _buildTimeline(currentStatus),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                "Delivery Address",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            _buildMapSection(),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Back to Orders",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderIdSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Item",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                order['title'] ?? "Food Order",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const Icon(Icons.fastfood, color: primaryPurple, size: 24),
        ],
      ),
    );
  }

  Widget _buildTimeline(String status) {
    // UPDATED LOGIC: Matching the strings from your OrdersPage simulation
    bool isPlaced = true; // Always true if we are on this page
    bool isPreparing =
        status == 'Preparing' ||
        status == 'Out for Delivery' ||
        status == 'Delivered';
    bool isOutForDelivery =
        status == 'Out for Delivery' || status == 'Delivered';
    bool isDelivered = status == 'Delivered';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          _timelineItem(
            "Order Placed",
            "We have received your order",
            "Just now",
            isPlaced,
            true,
          ),
          _timelineItem(
            "Preparing",
            "Chef is cooking your food",
            isPreparing ? "In Progress" : "Waiting",
            isPreparing,
            true,
          ),
          _timelineItem(
            "On the Way",
            "Rider is heading to you",
            isOutForDelivery ? "En Route" : "---",
            isOutForDelivery,
            true,
          ),
          _timelineItem(
            "Delivered",
            "Enjoy your meal!",
            isDelivered ? "Done" : "---",
            isDelivered,
            false,
          ),
        ],
      ),
    );
  }

  Widget _timelineItem(
    String title,
    String sub,
    String time,
    bool isDone,
    bool hasNext,
  ) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDone ? primaryPurple : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDone ? primaryPurple : Colors.grey.shade300,
                  ),
                ),
                child: isDone
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
              if (hasNext)
                Expanded(
                  child: VerticalDivider(
                    color: isDone ? primaryPurple : Colors.grey.shade300,
                    thickness: 2,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDone ? Colors.black : Colors.grey,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Icon(Icons.map_outlined, color: primaryPurple, size: 40),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Row(
              children: [
                Icon(Icons.location_on, color: primaryPurple),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Tagum City, Davao Region, Philippines",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
