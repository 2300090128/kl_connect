import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful")),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Register"),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(20),

            child: Card(
              elevation: 8, // 🔥 improved shadow
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      /// 🔹 Title
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003366),
                        ),
                      ),

                      const SizedBox(height: 20),

                      _buildField(
                        controller: nameController,
                        label: "Full Name",
                        icon: Icons.person,
                        validator: (value) =>
                            value!.isEmpty ? "Enter your name" : null,
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        controller: emailController,
                        label: "Email",
                        icon: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) return "Enter email";
                          if (!value.contains("@")) return "Invalid email";
                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        controller: mobileController,
                        label: "Mobile",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.length < 10 ? "Invalid mobile number" : null,
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        controller: departmentController,
                        label: "Department",
                        icon: Icons.school,
                        validator: (value) =>
                            value!.isEmpty ? "Enter department" : null,
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        controller: yearController,
                        label: "Year",
                        icon: Icons.calendar_today,
                        validator: (value) =>
                            value!.isEmpty ? "Enter year" : null,
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        controller: passwordController,
                        label: "Password",
                        icon: Icons.lock,
                        obscureText: true,
                        validator: (value) =>
                            value!.length < 6 ? "Min 6 characters" : null,
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        controller: confirmPasswordController,
                        label: "Confirm Password",
                        icon: Icons.lock_outline,
                        obscureText: true,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 Register Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003366),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14), // ✅ fixed
                            ),
                          ),
                          child: const Text("Register"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Improved Input Field
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}