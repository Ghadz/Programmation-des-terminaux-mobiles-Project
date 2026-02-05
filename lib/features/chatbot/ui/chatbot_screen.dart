import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);
  
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  
  // Get your free API key from: https://makersuite.google.com/app/apikey
  // final String apiKey = 'AIzaSyAtvq6WHLFKtXWAd6iS2SAWT-3b-nfZnn4';
  final String apiKey = 'PXURHLKUR6';

  Future<String> askWolfram(String question) async {
    final encodedQuery = Uri.encodeComponent(question);

    final url = Uri.parse(
      "https://api.wolframalpha.com/v1/result?i=$encodedQuery&appid=$apiKey",
    );

    try {
      final response = await http.get(url);
      print(response);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Wolfram couldn't understand that 🤔";
      }
    } catch (e) {
      print("Error: $e");
      return "Connection error 🚫";
    }
  }

  void sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    
    setState(() {
      messages.add({'role': 'user', 'text': message});
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      // final response = await getChatbotResponse(message);
      final response = await askWolfram(message);
      setState(() {
        messages.add({'role': 'bot', 'text': response});
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        messages.add({'role': 'bot', 'text': 'Sorry, I encountered an error. Please try again.'});
        _isLoading = false;
      });
    }
  }
    Future<String> getChatbotResponse(String userMessage) async {
        final url = Uri.parse('https://chatgpt.com/');
      // or 10.0.2.2 / 192.168.x.x depending on device

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userMessage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['reply']; // ✅ correct key
      } else {
        debugPrint('Backend error ${response.statusCode}: ${response.body}');
        throw Exception('Failed to get chatbot response');
      }
    }



  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🚀 Space Chatbot"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade900, Colors.black],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.rocket_launch, size: 64, color: Colors.white54),
                          SizedBox(height: 16),
                          Text(
                            'Ask me about space! 🌌',
                            style: TextStyle(color: Colors.white54, fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        final isUser = msg['role'] == 'user';
                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75,
                            ),
                            decoration: BoxDecoration(
                              color: isUser ? Colors.blue.shade700 : Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              msg['text']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            Container(
              margin:const EdgeInsets.only(bottom: 100),
              padding: const EdgeInsets.all(8.0),
              color: Colors.black54,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Ask about space...",
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (text) => sendMessage(text),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade700,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => sendMessage(_controller.text),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}