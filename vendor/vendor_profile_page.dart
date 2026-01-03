import 'package:bahay_kusina/customer/notification_page.dart';
import 'package:bahay_kusina/main/login_page.dart';
import 'package:bahay_kusina/vendor/order_history.dart';
import 'package:bahay_kusina/vendor/support_page.dart';
import 'package:flutter/material.dart';
import 'account_settings_page.dart';

class VendorProfilePage extends StatefulWidget {
  const VendorProfilePage({super.key});

  @override
  State<VendorProfilePage> createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage> {
  // Theme Colors
  static const Color primaryOrange = Color(0xFFFF5722);
  static const Color secondaryOrange = Color(0xFFFF8A50);

  // You can eventually pull these from a database/controller
  String businessName = "Nanay's Kitchen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildProfileItem(
                  context,
                  Icons.person_outline,
                  "Account Settings",
                ),
                _buildProfileItem(
                  context,
                  Icons.notifications_none,
                  "Notifications",
                ),
                _buildProfileItem(context, Icons.history, "Order History"),
                _buildProfileItem(
                  context,
                  Icons.help_outline,
                  "Help & Support",
                ),
                const Divider(
                  height: 40,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                _buildLogoutItem(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HEADER (Matches Dashboard Style) ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryOrange, secondaryOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$businessName Vendor",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const Spacer(),
          // Profile Avatar with Border
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: primaryOrange, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  // --- PROFILE MENU ITEM ---
  Widget _buildProfileItem(BuildContext context, IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primaryOrange, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        onTap: () async {
          Widget nextPage;

          if (title == "Account Settings") {
            nextPage = const AccountSettingsPage();
          } else if (title == "Notifications") {
            nextPage = const NotificationsPage();
          } else if (title == "Order History") {
            nextPage = const OrderHistoryPage();
          } else if (title == "Help & Support") {
            nextPage = const HelpSupportPage();
          } else {
            return;
          }

          // We use await to refresh the page once the user returns from a sub-page
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );

          setState(() {
            // This triggers if the business name was changed in settings
          });
        },
      ),
    );
  }

  // --- LOGOUT ITEM ---
  Widget _buildLogoutItem(BuildContext context) {
    return InkWell(
      onTap: () => _showLogoutDialog(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.red.withOpacity(0.1)),
        ),
        child: const Row(
          children: [
            Icon(Icons.logout_rounded, color: Colors.red, size: 22),
            SizedBox(width: 15),
            Text(
              "Logout Account",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.red, size: 14),
          ],
        ),
      ),
    );
  }

  // --- LOGOUT CONFIRMATION ---
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to exit your session?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Stay", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
