import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  static const Color primaryOrange = Color(0xFFFF5722);

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
          "Help & Support",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TOP SEARCH BAR ---
            TextField(
              decoration: InputDecoration(
                hintText: "Search for help...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- QUICK CONTACT CARD ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryOrange, Color(0xFFFF8A50)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: 25,
                    child: Icon(
                      Icons.support_agent,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Need immediate help?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Our team is available 24/7",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- FAQ CATEGORIES ---
            _buildSectionLabel("Common Topics"),
            _buildSupportTile(
              Icons.help_outline,
              "How to manage orders",
              "Guide for new vendors",
            ),
            _buildSupportTile(
              Icons.payment,
              "Payment & Payouts",
              "Understand how you get paid",
            ),
            _buildSupportTile(
              Icons.assignment_late_outlined,
              "Complaint Resolution",
              "How we handle disputes",
            ),

            const SizedBox(height: 25),

            // --- CONTACT OPTIONS ---
            _buildSectionLabel("Reach Out to Us"),
            _buildContactCard(
              Icons.email_outlined,
              "Email Support",
              "support@bahaykusina.com",
            ),
            _buildContactCard(
              Icons.phone_outlined,
              "Phone Call",
              "+63 912 345 6789",
            ),
            _buildContactCard(
              Icons.chat_bubble_outline,
              "Live Chat",
              "Chat with an agent now",
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 15),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSupportTile(IconData icon, String title, String sub) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: primaryOrange),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          sub,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
        onTap: () {},
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          detail,
          style: const TextStyle(fontSize: 13, color: primaryOrange),
        ),
        onTap: () {},
      ),
    );
  }
}
