import 'package:bahay_kusina/vendor/data_model.dart';
import 'package:flutter/material.dart';

class AddPackagePage extends StatefulWidget {
  final MealPackage? existingPackage;
  const AddPackagePage({super.key, this.existingPackage});

  @override
  State<AddPackagePage> createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String _selectedCategory = "Breakfast";
  final List<String> _categories = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snacks",
    "Dessert",
  ];

  static const Color primaryOrange = Color(0xFFFF5722);

  @override
  void initState() {
    super.initState();
    if (widget.existingPackage != null) {
      _nameController.text = widget.existingPackage!.name;
      _descController.text = widget.existingPackage!.description;
      _priceController.text = widget.existingPackage!.price;
      _stockController.text = widget.existingPackage!.stock;
      _selectedCategory = widget.existingPackage!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.existingPackage == null ? "Add New Package" : "Edit Package",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.grey[400],
                      size: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Upload Food Image",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildLabel("Package Name"),
            _buildTextField(_nameController, "e.g. Ultimate Breakfast Package"),
            _buildLabel("Category"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildLabel("Description"),
            _buildTextField(
              _descController,
              "Describe the meal items...",
              maxLines: 3,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Price (₱)"),
                      _buildTextField(_priceController, "0.00", isNumber: true),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Stock"),
                      _buildTextField(_stockController, "Qty", isNumber: true),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Validate basic inputs
                  if (_nameController.text.isEmpty ||
                      _priceController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill in Name and Price"),
                      ),
                    );
                    return;
                  }

                  // Create the package object and return it
                  final updatedPackage = MealPackage(
                    name: _nameController.text,
                    category: _selectedCategory,
                    description: _descController.text,
                    price: _priceController.text,
                    stock: _stockController.text,
                  );
                  Navigator.pop(context, updatedPackage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Save Package",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 4),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  );

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    bool isNumber = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[50],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryOrange),
        ),
      ),
    ),
  );
}
