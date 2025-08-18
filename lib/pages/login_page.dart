import 'package:flutter/material.dart';
import '../app_state.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'splash_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _tryLogin() {
    if (!AppState.hasAccount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No account found. Please sign up first.')),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      AppState.isLoggedIn = true;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (_) => false,
      );
    }
  }

  // ✅ Simple email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Enter your email";
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  // ✅ Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Enter your password";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  Widget _socialLoginButton(String text, IconData icon, Color color) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        side: BorderSide(color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$text login not implemented (UI only)')),
        );
      },
      icon: Icon(icon, color: color),
      label: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SplashPage()),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text('Log in to continue',
                style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 20),

            // ✅ Login form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Forgot Password? (UI only)')),
                        );
                      },
                      child: const Text("Forgot password?"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: _tryLogin,
                      child: const Text('Log in'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Divider with text
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade400)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("or continue with"),
                ),
                Expanded(child: Divider(color: Colors.grey.shade400)),
              ],
            ),
            const SizedBox(height: 16),

            // ✅ Social buttons
            _socialLoginButton("Continue with Google", Icons.g_mobiledata,
                Colors.redAccent),
            const SizedBox(height: 12),
            _socialLoginButton(
                "Continue with Facebook", Icons.facebook, Colors.blue),
            const SizedBox(height: 12),
            _socialLoginButton("Continue with Apple", Icons.apple, Colors.black),

            const SizedBox(height: 32),

            // ✅ Bottom Sign up link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New here?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()),
                    );
                  },
                  child: const Text('Create an account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
