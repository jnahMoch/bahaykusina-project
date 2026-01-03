import 'package:flutter/material.dart';
import '../customer/main_screen.dart';
import '../vendor/vendor_home_page.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color secondaryOrange = Color(0xFFFF8C3B);
  String selectedRole = "Customer";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitSignUp() {
    // Determine target based on role
    final Widget targetPage = selectedRole == "Customer"
        ? const MainScreen()
        : const VendorHomePage();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Signing up as $selectedRole..."),
        backgroundColor: secondaryOrange,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "I want to sign up as a",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildRoleSelector(),
                    const SizedBox(height: 25),
                    _buildTextField(
                      _nameController,
                      "Full Name",
                      "Juan Dela Cruz",
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      _emailPhoneController,
                      "Email or Phone",
                      "juan@example.com",
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      _passwordController,
                      "Password",
                      "******",
                      isObscure: true,
                    ),
                    const SizedBox(height: 30),
                    _buildSignUpButton(),
                    const SizedBox(height: 20),
                    _buildLoginLink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Row(
      children: [
        _roleButton("Customer"),
        const SizedBox(width: 10),
        _roleButton("Vendor"),
      ],
    );
  }

  Widget _roleButton(String role) {
    bool isSelected = selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedRole = role),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? primaryOrange.withOpacity(0.1) : Colors.white,
            border: Border.all(
              color: isSelected ? primaryOrange : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              role,
              style: TextStyle(
                color: isSelected ? primaryOrange : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [primaryOrange, secondaryOrange]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: const Text(
        "Create Account",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    bool isObscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(initialRole: selectedRole),
          ),
        ),
        child: const Text(
          "Already have an account? Log In",
          style: TextStyle(color: primaryOrange),
        ),
      ),
    );
  }
}
