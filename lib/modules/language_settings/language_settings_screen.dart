import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:copartner/services/language_provider.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  late String _tempSelectedLanguage; // "English" or "Tagalog"
  double _radioFontSize = 20.0; // Editable font size for radio button text

  @override
  void initState() {
    super.initState();
    // Get current language from provider to set the initial radio selection
    final isEnglish = context.read<LanguageProvider>().isEnglish;
    _tempSelectedLanguage = isEnglish ? "English" : "Tagalog";
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final bool isEnglish = languageProvider.isEnglish;

    final screenTitle = isEnglish ? "Language Settings" : "Mga Setting ng Wika";
    final promptText = isEnglish
        ? "Select your preferred language:"
        : "Piliin ang iyong gustong wika:";
    final saveBtnText = isEnglish ? "Save" : "I-save";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          screenTitle,
          style: const TextStyle(
            fontSize: 25,
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
            const SizedBox(height: 20),
            Text(
              promptText,
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "Alumni Sans",
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            // English RadioListTile
            RadioListTile<String>(
              title: Text(
                "English",
                style: TextStyle(
                  fontFamily: "Alumni Sans",
                  fontSize: _radioFontSize,
                ),
              ),
              value: "English",
              groupValue: _tempSelectedLanguage,
              onChanged: (value) {
                setState(() {
                  _tempSelectedLanguage = value!;
                });
              },
            ),

            // Tagalog RadioListTile
            RadioListTile<String>(
              title: Text(
                "Tagalog",
                style: TextStyle(
                  fontFamily: "Alumni Sans",
                  fontSize: _radioFontSize,
                ),
              ),
              value: "Tagalog",
              groupValue: _tempSelectedLanguage,
              onChanged: (value) {
                setState(() {
                  _tempSelectedLanguage = value!;
                });
              },
            ),
            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Update the global language
                  languageProvider.setLanguage(_tempSelectedLanguage);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD62229),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  saveBtnText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Alumni Sans',
                    fontSize: 20,
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
}
