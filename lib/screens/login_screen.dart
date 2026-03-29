import 'package:flutter/material.dart';
import '../main.dart' as main; // 🔥 for userRole

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    /// 🔥 ADMIN CHECK
    if (emailController.text.trim() == "admin@kl.com") {
      main.userRole = "admin";
    } else {
      main.userRole = "user";
    }

    setState(() {
      isLoading = false;
    });

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // 🔥 FIX
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(12),

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 20),

                    /// 🔥 TITLE
                    Text(
                      "Welcome Back 👋",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Login to continue",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    /// 📧 EMAIL
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 🔒 PASSWORD
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔁 FORGOT
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot');
                        },
                        child: const Text("Forgot Password?"),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// 🔥 LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003366),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Login"),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔗 REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Color(0xFF003366),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}