import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_drawer.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  final AIService _aiService = AIService();

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final userMessage = _messageController.text;
    _messageController.clear();

    setState(() {
      _messages.add({
        'role': 'user',
        'text': userMessage,
      });
      _isLoading = true;
    });

    try {
      final response = await _aiService.chatWithAI(userMessage);

      setState(() {
        _messages.add({
          'role': 'ai',
          'text': response,
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("🤖 AI Chat"),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome, size: 60, color: Colors.amber),
                        SizedBox(height: 16),
                        Text(
                          "Ask me anything!",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "I'm here to help with your studies,\nplacements, and more.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isUser = message['role'] == 'user';

                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? const Color(0xFF003366)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          child: Text(
                            message['text'] ?? '',
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Loading Indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF003366),
                  ),
                ),
              ),
            ),

          // Input Field
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ask AI...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    enabled: !_isLoading,
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  backgroundColor: const Color(0xFF003366),
                  onPressed: _isLoading ? null : _sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
