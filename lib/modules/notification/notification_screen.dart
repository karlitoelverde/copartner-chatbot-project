import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:copartner/modules/home/home_screen.dart';
import 'package:copartner/modules/chat-module/chat_screen.dart';
import 'package:copartner/modules/profile/profile_screen.dart';
import 'package:copartner/modules/settings/settings_screen.dart';
import 'package:copartner/services/language_provider.dart';

class NotificationScreen extends StatefulWidget {
  final int initialIndex;
  const NotificationScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider>().isEnglish;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "CO",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Alumni Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              TextSpan(
                text: "PARTNER",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Alumni Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Already on NotificationScreen, no need to navigate.
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          isEnglish 
              ? "You have no notification yet." 
              : "Wala ka pang notification.",
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Alumni Sans',
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: isEnglish ? "Home" : "Home",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chat),
            ),
            label: isEnglish ? "Chat" : "Chat",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: isEnglish ? "Profile" : "Profile",
          ),
        ],
      ),
    );
  }
}