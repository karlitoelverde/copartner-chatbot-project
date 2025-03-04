import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/language_provider.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Validate that username is not blank and contains '@'
    if (username.isEmpty || !username.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    // Validate that password is not blank and has at least 12 characters
    if (password.isEmpty || password.length < 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password must be at least 12 characters.')),
      );
      return;
    }

    // If validations pass, navigate to HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access the current language from LanguageProvider
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isEnglish = languageProvider.isEnglish;

    // Switch text based on language selection
    final loginTitle =
        isEnglish ? 'Login your Account' : 'Mag-login sa iyong Account';
    final loginSubtitle = isEnglish
        ? 'Enter your LDIMS account to continue.'
        : 'Ilagay ang iyong mga detalye sa LDIMS account upang magpatuloy.';
    final usernameLabel = isEnglish ? 'Username' : 'Username';
    final passwordLabel = isEnglish ? 'Password' : 'Password';
    final loginButtonText = isEnglish ? 'LOGIN' : 'MAG-LOGIN';

    // Set the fixed width for text fields and the button (75% of screen width)
    final double fieldWidth = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Policeman + CoPartner image
                Image.asset(
                  'assets/images/copartner-withname.png',
                  width: 180,
                ),
                const SizedBox(height: 20),
                // Title
                Text(
                  loginTitle,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Alumni Sans",
                  ),
                ),
                const SizedBox(height: 0),
                // Subtitle
                Text(
                  loginSubtitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Alumni Sans",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Username TextField with fixed width
                SizedBox(
                  width: fieldWidth,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: usernameLabel,
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(fontFamily: "Alumni Sans"),
                  ),
                ),
                const SizedBox(height: 16),
                // Password TextField with fixed width
                SizedBox(
                  width: fieldWidth,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: passwordLabel,
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(fontFamily: "Alumni Sans"),
                  ),
                ),
                const SizedBox(height: 24),
                // Login Button with fixed width and background color #2F3295
                SizedBox(
                  width: fieldWidth,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F3295),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      loginButtonText,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Alumni Sans",
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
