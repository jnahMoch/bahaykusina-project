import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String userRole;
  const ForgotPasswordPage({super.key, required this.userRole});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color secondaryOrange = Color(0xFFFF8C3B);
  final TextEditingController _emailController = TextEditingController();

  void _submitResetRequest() {
    if (_emailController.text.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Reset link sent for ${widget.userRole} account"),
        backgroundColor: Colors.green,
      ),
    );
    Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recover ${widget.userRole} Account",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your email to receive reset instructions.",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitResetRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Send Reset Link",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [primaryOrange, secondaryOrange]),
      ),
      child: IconButton(
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
