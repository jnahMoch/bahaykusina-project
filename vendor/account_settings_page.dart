import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  static const Color primaryOrange = Color(0xFFFF5722);

  // Business Info Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  // State States
  bool _isEditing = false;
  bool _isVerified = false; // Set to false to show the OTP flow
  bool _loginAlertsEnabled = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Nanay's Kitchen");
    _emailController = TextEditingController(text: "nanay@kitchen.com");
    _phoneController = TextEditingController(text: "+63 912 345 6789");
    _addressController = TextEditingController(text: "123 Street, Quezon City");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
          "Account Settings",
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
                if (_isEditing) {
                  _showSnackBar("Profile updated successfully!", Colors.green);
                }
                _isEditing = !_isEditing;
              });
            },
            child: Text(
              _isEditing ? "SAVE" : "EDIT",
              style: const TextStyle(
                color: primaryOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(),
            const SizedBox(height: 25),

            _buildSectionLabel("Business Information"),
            _buildSettingsCard([
              _buildEditTile(
                Icons.storefront_outlined,
                "Store Name",
                _nameController,
              ),
              _buildEditTile(
                Icons.email_outlined,
                "Business Email",
                _emailController,
              ),
              _buildEditTile(
                Icons.phone_outlined,
                "Phone Number",
                _phoneController,
              ),
              _buildEditTile(
                Icons.location_on_outlined,
                "Store Address",
                _addressController,
              ),
            ]),

            const SizedBox(height: 20),
            _buildSectionLabel("Security & Access"),
            _buildSettingsCard([
              _buildActionTile(
                Icons.lock_reset_outlined,
                "Change Password",
                "",
                onTap: _showPasswordDialog,
              ),
              _buildVerificationTile(),
              _buildSwitchTile(
                Icons.notifications_active_outlined,
                "Login Alerts",
              ),
            ]),

            const SizedBox(height: 20),
            _buildSectionLabel("Danger Zone"),
            _buildSettingsCard([
              _buildActionTile(
                Icons.delete_outline,
                "Deactivate Account",
                "",
                color: Colors.red,
                onTap: _showDeactivateDialog,
              ),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.person, size: 40, color: Colors.grey),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: primaryOrange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _nameController.text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Vendor ID: BK-9921",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditTile(
    IconData icon,
    String title,
    TextEditingController controller,
  ) {
    return ListTile(
      leading: _buildIconBox(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: TextField(
        controller: controller,
        enabled: _isEditing,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          border: InputBorder.none,
        ),
      ),
      trailing: _isEditing
          ? const Icon(Icons.edit, size: 14, color: primaryOrange)
          : const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
    );
  }

  Widget _buildVerificationTile() {
    return ListTile(
      leading: _buildIconBox(Icons.verified_user_outlined),
      title: const Text(
        "Identity Verification",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isVerified ? "Verified" : "Verify Now",
            style: TextStyle(
              color: _isVerified ? Colors.green : Colors.red,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
        ],
      ),
      onTap: _isVerified ? null : _showOTPDialog,
    );
  }

  Widget _buildSwitchTile(IconData icon, String title) {
    return ListTile(
      leading: _buildIconBox(icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: Switch(
        value: _loginAlertsEnabled,
        activeColor: primaryOrange,
        onChanged: (val) {
          setState(() => _loginAlertsEnabled = val);
        },
      ),
    );
  }

  Widget _buildActionTile(
    IconData icon,
    String title,
    String value, {
    Color color = Colors.black87,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: _buildIconBox(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
      onTap: onTap,
    );
  }

  Widget _buildIconBox(IconData icon, {Color? color}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color == Colors.red
            ? Colors.red.withOpacity(0.1)
            : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color ?? primaryOrange, size: 20),
    );
  }

  // --- DIALOGS ---

  void _showOTPDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Email Verification"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Enter the 4-digit code sent to your email",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 4,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 15,
              ),
              decoration: InputDecoration(
                counterText: "",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              setState(() => _isVerified = true);
              Navigator.pop(context);
              _showSnackBar("Account Verified!", Colors.green);
            },
            child: const Text("Verify", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDeactivateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Deactivate Account?",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Your store will be hidden from customers. You can reactivate by logging in again.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Keep Account"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Deactivate",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPopupField("Current Password"),
            _buildPopupField("New Password"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Update", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // --- UTILS ---

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildSectionLabel(String label) => Container(
    width: double.infinity,
    padding: const EdgeInsets.only(left: 30, bottom: 10),
    child: Text(
      label.toUpperCase(),
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 11,
        letterSpacing: 1.2,
      ),
    ),
  );

  Widget _buildSettingsCard(List<Widget> tiles) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
      ],
    ),
    child: Column(children: tiles),
  );
}
