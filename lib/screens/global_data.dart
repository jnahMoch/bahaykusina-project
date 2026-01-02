import 'package:flutter/material.dart';

// --- CART & ORDERS ---
List<Map<String, dynamic>> myOrders = [];
int cartCount = 0;

// --- USER PROFILE DATA ---
String userName = "Jana Boo";
String userEmail = "janaboo@example.com";
String userPhone = "09534068346";

// --- NOTIFICATIONS DATA ---
List<Map<String, dynamic>> userNotifications = [
  {
    "title": "Order Picked Up",
    "body": "Your order from Jollibee is on the way!",
    "time": "2 mins ago",
    "isRead": false,
    "icon": Icons.delivery_dining,
  },
  {
    "title": "Promo Alert",
    "body": "Use code 'FOOD50' to get ₱50 off your next meal.",
    "time": "1 hour ago",
    "isRead": false,
    "icon": Icons.local_offer,
  },
];

// --- SHIPPING ADDRESS DATA ---
List<Map<String, dynamic>> userAddresses = [
  {
    "name": "Jana Boo",
    "phone": "09534068346",
    "address": "Prk Kalambuan, Magugpo North, Tagum City",
    "isSelected": true,
  },
];

// --- NEW EXPANDED PAYMENT METHODS DATA ---
// Added Maya, Credit Card, and COD for a complete checkout experience
List<Map<String, dynamic>> userPaymentMethods = [
  {
    "type": "GCash",
    "subtitle": "0953 **** 346",
    "icon": Icons.account_balance_wallet,
    "isSelected": true, // Default selection
  },
  {
    "type": "Maya",
    "subtitle": "0953 **** 346",
    "icon": Icons.wallet,
    "isSelected": false,
  },
  {
    "type": "Credit Card",
    "subtitle": "**** **** **** 1234",
    "icon": Icons.credit_card,
    "isSelected": false,
  },
  {
    "type": "Cash on Delivery",
    "subtitle": "Pay when food arrives",
    "icon": Icons.payments_outlined,
    "isSelected": false,
  },
];

// --- APP THEME COLORS ---
class AppColors {
  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color secondaryOrange = Color(0xFFFF8A00);
  static const Color backgroundGrey = Color(0xFFF8F9FA);
}
