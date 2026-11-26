import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const green = Color(0xFF1F6F54);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final ValueNotifier<bool> hidePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    hidePassword.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: green, width: 1.5),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 16),
    child: Text(text,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
  );

  void _signup() {
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords not match ')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 66,
                    width: 66,
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.home_outlined,
                        color: Colors.white, size: 38),
                  ),
                  const SizedBox(width: 16),
                  const Text('Kiraaya',
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(height: 40),
              const Text('Create account',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('Sign up to manage your rent.',
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade700)),

              _label('Full name'),
              TextFormField(
                controller: nameController,
                decoration: _decoration('Your name'),
              ),

              _label('Email'),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration('you@example.com'),
              ),

              _label('Password'),
              ValueListenableBuilder<bool>(
                valueListenable: hidePassword,
                builder: (context, hide, child) {
                  return TextFormField(
                    controller: passwordController,
                    obscureText: hide,
                    decoration: _decoration(
                      'At least 6 characters',
                      suffix: IconButton(
                        icon: Icon(hide
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () => hidePassword.value = !hide,
                      ),
                    ),
                  );
                },
              ),

              _label('Confirm password'),
              ValueListenableBuilder<bool>(
                valueListenable: hidePassword,
                builder: (context, hide, child) {
                  return TextFormField(
                    controller: confirmController,
                    obscureText: hide,
                    decoration: _decoration('Re-enter password'),
                  );
                },
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text('Sign up',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(color: Colors.grey.shade700)),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Log in',
                        style: TextStyle(
                            color: green, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}