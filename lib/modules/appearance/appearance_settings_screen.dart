import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:copartner/services/theme_provider.dart';
import 'package:copartner/services/language_provider.dart';

class AppearanceSettingsScreen extends StatefulWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  State<AppearanceSettingsScreen> createState() =>
      _AppearanceSettingsScreenState();
}

class _AppearanceSettingsScreenState extends State<AppearanceSettingsScreen> {
  late bool _tempIsDarkMode;

  @override
  void initState() {
    super.initState();
    _tempIsDarkMode = context.read<ThemeProvider>().isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();
    final isEnglish = languageProvider.isEnglish;

    final screenTitle =
        isEnglish ? "Appearance Settings" : "Mga Setting ng Hitsura";
    final headingText = isEnglish
        ? "Select Appearance Mode:"
        : "Piliin ang Mode ng Hitsura:";
    final lightText = isEnglish ? "Light Mode" : "Maliwanag";
    final darkText = isEnglish ? "Dark Mode" : "Madilim";
    final saveText =
        isEnglish ? "Save and Go Back" : "I-save at Bumalik";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          screenTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Alumni Sans",
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              headingText,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "Alumni Sans",
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            RadioListTile<bool>(
              title: Text(
                lightText,
                style: const TextStyle(
                  fontFamily: "Alumni Sans",
                  fontSize: 18,
                ),
              ),
              value: false,
              groupValue: _tempIsDarkMode,
              onChanged: (val) {
                setState(() {
                  _tempIsDarkMode = val!;
                });
              },
            ),
            RadioListTile<bool>(
              title: Text(
                darkText,
                style: const TextStyle(
                  fontFamily: "Alumni Sans",
                  fontSize: 18,
                ),
              ),
              value: true,
              groupValue: _tempIsDarkMode,
              onChanged: (val) {
                setState(() {
                  _tempIsDarkMode = val!;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                themeProvider.setDarkMode(_tempIsDarkMode);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD62229),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                saveText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Alumni Sans",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
