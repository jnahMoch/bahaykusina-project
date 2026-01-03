import 'signup_page.dart';
import 'forgot_password_page.dart';
import 'package:flutter/material.dart';
import '../customer/main_screen.dart';
import '../vendor/vendor_home_page.dart'; // <--- 1. ENSURE THIS IMPORT IS CORRECT

class LoginPage extends StatefulWidget {
  final String initialRole;
  const LoginPage({super.key, this.initialRole = "Customer"});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 0 = Customer, 1 = Vendor
  late int _selectedUserType;
  bool _isPasswordVisible = false;
  static const Color primaryOrange = Color(0xFFFF5722);

  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Sets the toggle based on where the user came from
    _selectedUserType = widget.initialRole == "Vendor" ? 1 : 0;
  }

  void _handleLogin() {
    String email = _identifierController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // --- FIX IS HERE ---
    if (_selectedUserType == 1) {
      // If VENDOR is selected, go to VendorHomePage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const VendorHomePage()),
        (route) => false, // Clears the navigation stack
      );
    } else {
      // If CUSTOMER is selected, go to MainScreen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "I am a",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  _buildUserToggle(),
                  const SizedBox(height: 25),
                  const Text(
                    "Email or Phone",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _identifierController,
                    hint: "Email or Phone",
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildPasswordField(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(
                              userRole: _selectedUserType == 1
                                  ? "Vendor"
                                  : "Customer",
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: primaryOrange),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildLoginButton(),
                  const SizedBox(height: 30),
                  _buildSignUpLink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserToggle() {
    return Row(
      children: [
        _toggleButton("Customer", 0),
        const SizedBox(width: 15),
        _toggleButton("Vendor", 1),
      ],
    );
  }

  Widget _toggleButton(String label, int index) {
    bool isSelected = _selectedUserType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedUserType = index),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFF3E0) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primaryOrange : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: "Enter password",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Log In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [primaryOrange, Color(0xFFFF8A50)]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: const Center(
        child: Text(
          "Welcome Back",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpPage()),
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
