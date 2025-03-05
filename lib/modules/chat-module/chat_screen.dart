import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:copartner/services/language_provider.dart';

// English solutions
final Map<String, String> solutionsEnglish = {
  "Wrong Username or Password":
      "Ensure that your username and password are correct. Reset your password if needed.",
  "Exceeded Login Attempts":
      "Your account is temporarily locked. Try again after 15 minutes or reset your password.",
  "Invalid Verification Code":
      "Ensure you enter the latest verification code sent to your email or phone.",
  "Account Deactivation/Restriction":
      "Contact IT support for account reactivation requests.",
  "Deactivation of Old Users":
      "Administrators can deactivate users via the user management panel.",
  "Updating Contact Information":
      "Go to settings and update your phone number and email.",
  "New Issuance Issues":
      "Ensure that all required documents are submitted for firearm issuance.",
  "Turn-in & Reissuance Issues":
      "Report any turn-in discrepancies to the Logistics Division.",
  "On-Stock Firearm Issues":
      "Verify inventory records and coordinate with supply officers.",
  "Missing Data in System":
      "Refresh your dashboard or check for system updates."
};

// Tagalog solutions
final Map<String, String> solutionsTagalog = {
  "Wrong Username or Password":
      "Siguraduhin na tama ang iyong username at password. I-reset ang iyong password kung kinakailangan.",
  "Exceeded Login Attempts":
      "Pansamantalang naka-lock ang iyong account. Subukang muli pagkatapos ng 15 minuto o i-reset ang iyong password.",
  "Invalid Verification Code":
      "Siguraduhin na naipasok mo ang pinakabagong verification code na ipinadala sa iyong email o telepono.",
  "Account Deactivation/Restriction":
      "Makipag-ugnayan sa IT support para sa reactivation ng iyong account.",
  "Deactivation of Old Users":
      "Maaaring i-deactivate ng administrador ang mga lumang user gamit ang user management panel.",
  "Updating Contact Information":
      "Pumunta sa settings at i-update ang iyong numero ng telepono at email.",
  "New Issuance Issues":
      "Siguraduhin na naipasa ang lahat ng kinakailangang dokumento para sa firearm issuance.",
  "Turn-in & Reissuance Issues":
      "I-report ang anumang discrepancy sa turn-in sa Logistics Division.",
  "On-Stock Firearm Issues":
      "I-verify ang inventory records at makipag-coordinate sa supply officers.",
  "Missing Data in System":
      "I-refresh ang iyong dashboard o i-check ang system updates."
};

Map<String, String> getSolutions(BuildContext context) {
  final isEnglish =
      Provider.of<LanguageProvider>(context, listen: false).isEnglish;
  return isEnglish ? solutionsEnglish : solutionsTagalog;
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final Map<String, List<String>> faqCategories = {
    "🔑 Login & Authentication Issues": [
      "Wrong Username or Password",
      "Exceeded Login Attempts",
      "Invalid Verification Code",
      "Account Deactivation/Restriction"
    ],
    "👤 User Account Management": [
      "Deactivation of Old Users",
      "Reactivation Requests",
      "Updating Contact Information"
    ],
    "🔫 Firearms Inventory & Issuance": [
      "New Issuance Issues",
      "Turn-in & Reissuance Issues",
      "On-Stock Firearm Issues"
    ],
    "⚠️ System Errors & Missing Data": [
      "Missing Data in System",
      "Technical Errors & Glitches"
    ],
    "📞 Contact Support": [
      "IT Support",
      "HR/Personnel Support",
      "Logistics/Firearms Division"
    ]
  };

  String? selectedCategory;
  String? selectedIssue;
  List<String> currentOptions = [];

  @override
  void initState() {
    super.initState();
    _startConversation();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Helper to format timestamp as HH:MM.
  String _formatTimestamp(DateTime timestamp) {
    return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _startConversation() {
    final isEnglish = context.read<LanguageProvider>().isEnglish;
    final greetingText = isEnglish
        ? "Hello! I'm CoPartner, your virtual assistant. How can I help you today? 😊"
        : "Magandang araw! Ako si CoPartner, ang iyong virtual assistant. Paano kita matutulungan ngayon? 😊";
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'sender': 'COPARTNER',
          'message': greetingText,
          'time': DateTime.now(),
        });
      });
      _scrollToBottom();
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        _showCategories();
      });
    });
  }

  void _showCategories() {
    final isEnglish = context.read<LanguageProvider>().isEnglish;
    final categoryPrompt = isEnglish
        ? "Please select a category below:"
        : "Pumili ng kategorya sa ibaba:";
    if (!mounted) return;
    setState(() {
      selectedCategory = null;
      selectedIssue = null;
      currentOptions = [];
      _messages.add({
        'sender': 'COPARTNER',
        'message': categoryPrompt,
        'options': faqCategories.keys.toList(),
        'type': 'category',
        'active': true,
        'time': DateTime.now(),
      });
    });
    _scrollToBottom();
  }

  void _handleCategorySelection(String category) {
    for (int i = _messages.length - 1; i >= 0; i--) {
      var msg = _messages[i];
      if (msg['type'] == 'category' && msg['active'] == true) {
        msg['active'] = false;
        msg['selectedOption'] = category;
        break;
      }
    }
    setState(() {
      selectedCategory = category;
      selectedIssue = null;
      currentOptions = faqCategories[category] ?? [];
      _messages.add({
        'sender': 'User',
        'message': category,
        'time': DateTime.now(),
      });
    });
    _scrollToBottom();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final isEnglish = context.read<LanguageProvider>().isEnglish;
      final issuePrompt =
          isEnglish ? "Please select an issue:" : "Pumili ng isyu:";
      setState(() {
        _messages.add({
          'sender': 'COPARTNER',
          'message': issuePrompt,
          'options': currentOptions,
          'type': 'subCategory',
          'active': true,
          'time': DateTime.now(),
        });
      });
      _scrollToBottom();
    });
  }

  void _handleIssueSelection(String issue) {
    for (int i = _messages.length - 1; i >= 0; i--) {
      var msg = _messages[i];
      if (msg['type'] == 'subCategory' && msg['active'] == true) {
        msg['active'] = false;
        msg['selectedOption'] = issue;
        break;
      }
    }
    setState(() {
      selectedIssue = issue;
      _messages.add({
        'sender': 'User',
        'message': issue,
        'time': DateTime.now(),
      });
    });
    _scrollToBottom();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final solutions = getSolutions(context);
      setState(() {
        _messages.add({
          'sender': 'COPARTNER',
          'message': solutions[issue] ??
              (context.read<LanguageProvider>().isEnglish
                  ? "Solution not found. Please contact support."
                  : "Walang nakitang solusyon. Makipag-ugnayan sa support."),
          'time': DateTime.now(),
        });
      });
      _scrollToBottom();
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        final isEnglish = context.read<LanguageProvider>().isEnglish;
        final helpfulPrompt = isEnglish
            ? "Was this solution helpful?"
            : "Nakatulong ba ang solusyon na ito?";
        setState(() {
          _messages.add({
            'sender': 'COPARTNER',
            'message': helpfulPrompt,
            'options': ["Yes ✅", "No ❌"],
            'time': DateTime.now(),
          });
        });
        _scrollToBottom();
      });
    });
  }

  void _handleFeedback(String feedback) {
    setState(() {
      _messages.add({
        'sender': 'User',
        'message': feedback,
        'time': DateTime.now(),
      });
    });
    _scrollToBottom();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final isEnglish = context.read<LanguageProvider>().isEnglish;
      final successText = isEnglish
          ? "Glad we could help! Returning to main menu."
          : "Ikinagagalak naming makatulong! Babalik tayo sa main menu.";
      final contactSupportText = isEnglish
          ? "Please contact support for further assistance."
          : "Mangyaring makipag-ugnayan sa support para sa karagdagang tulong.";
      setState(() {
        if (feedback == "Yes ✅") {
          _messages.add({
            'sender': 'COPARTNER',
            'message': successText,
            'time': DateTime.now(),
          });
          Future.delayed(const Duration(seconds: 2), () {
            if (!mounted) return;
            _showCategories();
          });
        } else {
          _messages.add({
            'sender': 'COPARTNER',
            'message': contactSupportText,
            'time': DateTime.now(),
          });
        }
      });
      _scrollToBottom();
    });
  }

  // Rule-based approach: get the best answer for a given message.
  String _getAnswer(String userMessage) {
    final solutions = getSolutions(context);
    final lowerMessage = userMessage.toLowerCase();
    String bestKey = "";
    int bestScore = 0;

    // Simple scoring: count how many words in the rule appear in the user message.
    for (final key in solutions.keys) {
      int score = 0;
      final words = key.toLowerCase().split(" ");
      for (final word in words) {
        if (lowerMessage.contains(word)) {
          score++;
        }
      }
      if (score > bestScore) {
        bestScore = score;
        bestKey = key;
      }
    }
    if (bestScore > 0) {
      return solutions[bestKey]!;
    } else {
      return context.read<LanguageProvider>().isEnglish
          ? "I'm sorry, I don't have an answer for that."
          : "Pasensya na, wala akong sagot para diyan.";
    }
  }

  // Modified _sendMessage to use the rule-based approach.
  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({
          'sender': 'User',
          'message': text,
          'time': DateTime.now(),
        });
        _textController.clear();
      });
      _scrollToBottom();

      // After a short delay, get the rule-based answer and add it as bot message.
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        final answer = _getAnswer(text);
        setState(() {
          _messages.add({
            'sender': 'COPARTNER',
            'message': answer,
            'time': DateTime.now(),
          });
        });
        _scrollToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBubbleColor =
        Theme.of(context).colorScheme.primary.withOpacity(0.2);
    final botBubbleColor = Theme.of(context).colorScheme.surfaceVariant;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Container(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message['sender'] == 'User';

                    final messageWidget = Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: isUser ? userBubbleColor : botBubbleColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(message['message']!),
                    );

                    final timestampWidget = Text(
                      _formatTimestamp(message['time']),
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    );

                    Widget? optionsWidget;
                    if (message.containsKey('options')) {
                      if (message['type'] == 'category') {
                        final isActive = message['active'] == true;
                        final options =
                            (message['options'] as List).cast<String>();
                        if (isActive) {
                          optionsWidget = Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: options.map((option) {
                              return OutlinedButton(
                                onPressed: () {
                                  _handleCategorySelection(option);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                child:
                                    Text(option, textAlign: TextAlign.center),
                              );
                            }).toList(),
                          );
                        } else {
                          final selectedOption =
                              message['selectedOption'] ?? "";
                          optionsWidget = Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: options.map((option) {
                              if (option == selectedOption) {
                                return ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2F3296),
                                    foregroundColor: Colors.white,
                                  ),
                                  child:
                                      Text(option, textAlign: TextAlign.center),
                                );
                              } else {
                                return OutlinedButton(
                                  onPressed: null,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  child:
                                      Text(option, textAlign: TextAlign.center),
                                );
                              }
                            }).toList(),
                          );
                        }
                      } else if (message['type'] == 'subCategory') {
                        final isActive = message['active'] == true;
                        final options =
                            (message['options'] as List).cast<String>();
                        if (isActive) {
                          optionsWidget = Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: options.map((option) {
                              return OutlinedButton(
                                onPressed: () {
                                  _handleIssueSelection(option);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                child:
                                    Text(option, textAlign: TextAlign.center),
                              );
                            }).toList(),
                          );
                        } else {
                          final selectedOption =
                              message['selectedOption'] ?? "";
                          optionsWidget = Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: options.map((option) {
                              if (option == selectedOption) {
                                return ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2F3296),
                                    foregroundColor: Colors.white,
                                  ),
                                  child:
                                      Text(option, textAlign: TextAlign.center),
                                );
                              } else {
                                return OutlinedButton(
                                  onPressed: null,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  child:
                                      Text(option, textAlign: TextAlign.center),
                                );
                              }
                            }).toList(),
                          );
                        }
                      } else {
                        final options =
                            (message['options'] as List).cast<String>();
                        optionsWidget = Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: options.map((option) {
                            return ElevatedButton(
                              onPressed: () {
                                if (faqCategories.containsKey(option)) {
                                  _handleCategorySelection(option);
                                } else if (getSolutions(context)
                                    .containsKey(option)) {
                                  _handleIssueSelection(option);
                                } else {
                                  _handleFeedback(option);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade50,
                                foregroundColor: Colors.black,
                              ),
                              child: Text(option, textAlign: TextAlign.center),
                            );
                          }).toList(),
                        );
                      }
                    }
                    return Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        messageWidget,
                        timestampWidget,
                        if (optionsWidget != null) optionsWidget,
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: _sendMessage,
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
