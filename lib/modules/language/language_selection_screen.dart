import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:copartner/modules/login/login_screen.dart';
import 'package:copartner/services/language_provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;
  Color _bgColor = Colors.white; // Default background color

  void _selectLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
      if (language == 'English') {
        _bgColor = const Color(0xFF303295); // Blue for English
      } else if (language == 'Tagalog') {
        _bgColor = const Color(0xFFc5272f); // Red for Tagalog
      } else {
        _bgColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Set heading text & color based on selection.
    String headingText = 'Choose your language';
    Color headingColor = Colors.black;
    if (_selectedLanguage == 'English') {
      headingText = 'Choose your language';
      headingColor = Colors.white;
    } else if (_selectedLanguage == 'Tagalog') {
      headingText = 'Piliin ang iyong wika';
      headingColor = Colors.white;
    }

    // Set the Save button label.
    String buttonLabel = '';
    if (_selectedLanguage == 'English') {
      buttonLabel = 'Save';
    } else if (_selectedLanguage == 'Tagalog') {
      buttonLabel = 'I-save';
    }

    // Define a width factor for language option boxes and the button.
    final double boxWidth = MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: _bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top image (e.g., a logo or illustration)
              Image.asset(
                'assets/images/language_book.png',
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 16),

              // Heading text (larger font)
              Text(
                headingText,
                style: TextStyle(
                  fontFamily: 'AlumniSans',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: headingColor,
                ),
              ),
              const SizedBox(height: 24),

              // English Option
              Center(
                child: SizedBox(
                  width: boxWidth,
                  child: GestureDetector(
                    onTap: () => _selectLanguage('English'),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedLanguage == 'English'
                              ? Colors.black
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row with a waving hand emoji and "Hello!" text.
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '👋',
                                    style: TextStyle(
                                      fontFamily: 'AlumniSans',
                                      fontSize: 22,
                                      color: Colors.yellow[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'Hello!',
                                    style: TextStyle(
                                      fontFamily: 'AlumniSans',
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // "How are you?" text.
                              const Text(
                                'How are you?',
                                style: TextStyle(
                                  fontFamily: 'AlumniSans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          // Bottom-right label.
                          const Positioned(
                            right: 0,
                            bottom: 0,
                            child: Text(
                              'English',
                              style: TextStyle(
                                fontFamily: 'AlumniSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Tagalog Option
              Center(
                child: SizedBox(
                  width: boxWidth,
                  child: GestureDetector(
                    onTap: () => _selectLanguage('Tagalog'),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedLanguage == 'Tagalog'
                              ? Colors.black
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row with a waving hand emoji and "Mabuhay!" text.
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '👋',
                                    style: TextStyle(
                                      fontFamily: 'AlumniSans',
                                      fontSize: 22,
                                      color: Colors.yellow[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'Mabuhay!',
                                    style: TextStyle(
                                      fontFamily: 'AlumniSans',
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // "Kamusta ka?" text.
                              const Text(
                                'Kamusta ka?',
                                style: TextStyle(
                                  fontFamily: 'AlumniSans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          // Bottom-right label.
                          const Positioned(
                            right: 0,
                            bottom: 0,
                            child: Text(
                              'Tagalog',
                              style: TextStyle(
                                fontFamily: 'AlumniSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Save / I-save Button
              if (_selectedLanguage != null && _selectedLanguage!.isNotEmpty)
                Center(
                  child: SizedBox(
                    width: boxWidth,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          // Update the global language state using Provider (without listening).
                          final languageProvider =
                              Provider.of<LanguageProvider>(
                            context,
                            listen: false,
                          );
                          languageProvider.setLanguage(_selectedLanguage!);

                          // Navigate to the LoginScreen.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0BA853),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: Text(
                          buttonLabel,
                          style: const TextStyle(
                            fontFamily: 'AlumniSans',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
