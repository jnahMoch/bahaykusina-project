import 'package:flutter/material.dart';
import 'global_data.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final Color primaryOrange = AppColors.primaryOrange;

  final List<Map<String, String>> faqs = [
    {
      "question": "How do I track my order?",
      "answer":
          "You can track your order in real-time by going to the 'Orders' tab and clicking on your active order.",
    },
    {
      "question": "Why is my GCash payment failing?",
      "answer":
          "Ensure you have enough balance and a stable internet connection. If the issue persists, try re-linking your GCash account.",
    },
    {
      "question": "Can I cancel my order?",
      "answer":
          "Orders can only be canceled within 5 minutes of placing them, provided the restaurant has not started preparing the food.",
    },
    {
      "question": "How to report a missing item?",
      "answer":
          "Go to your order history, select the order, and click 'Report Issue' to contact our support team immediately.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactCards(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Frequently Asked Questions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildFAQList(),
            const SizedBox(height: 30),
            _buildContactButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCards() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _buildSquareCard(Icons.headset_mic, "Live Chat", "Talk to us now"),
          const SizedBox(width: 15),
          _buildSquareCard(Icons.email_outlined, "Email", "Send us a mail"),
        ],
      ),
    );
  }

  Widget _buildSquareCard(IconData icon, String title, String subtitle) {
    return Expanded(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Connecting to $title...")));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: primaryOrange, size: 30),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: faqs.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.grey.shade100),
        itemBuilder: (context, index) {
          return ExpansionTile(
            shape: const Border(), // Removes the default border when expanded
            title: Text(
              faqs[index]['question']!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Text(
                  faqs[index]['answer']!,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContactButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: primaryOrange),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Redirecting to website...")),
          );
        },
        child: Text(
          "Visit our Website",
          style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
