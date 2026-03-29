import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  /// 🔑 Initialize with your Google Generative AI API key
  /// Get it from: https://makersuite.google.com/app/apikey
  static const String _apiKey = 'AIzaSyBHz-zG7EcQ6rGpm3PemnfletvbwJCQCy0';

  late final GenerativeModel _model;

  AIService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
  }

  /// 📰 SUMMARIZE NEWS - Get AI summary of news content
  Future<String> summarizeNews(String content) async {
    try {
      if (_apiKey == 'YOUR_API_KEY_HERE') {
        return "⚠️ AI API key not configured. Add your Google Generative AI key to use this feature.";
      }

      final response = await _model.generateContent([
        Content.text(
          "Summarize the following news article in exactly 3 bullet points. "
          "Be concise and highlight the most important information:\n\n$content",
        )
      ]);

      return response.text ?? "Unable to generate summary";
    } catch (e) {
      return "❌ Error generating summary: ${e.toString()}";
    }
  }

  /// 🤖 CHAT WITH AI - General conversation
  Future<String> chatWithAI(String userMessage) async {
    try {
      if (_apiKey == 'YOUR_API_KEY_HERE') {
        return "⚠️ AI API key not configured. Add your Google Generative AI key to use this feature.";
      }

      final response = await _model.generateContent([
        Content.text(userMessage)
      ]);

      return response.text ?? "No response from AI";
    } catch (e) {
      return "❌ Error: ${e.toString()}";
    }
  }

  /// 💡 GET STUDY TIPS - AI-generated study tips
  Future<String> getStudyTips(String subject) async {
    try {
      if (_apiKey == 'YOUR_API_KEY_HERE') {
        return "⚠️ AI API key not configured.";
      }

      final response = await _model.generateContent([
        Content.text(
          "Provide 3-4 practical study tips for learning $subject. "
          "Make them concise and actionable.",
        )
      ]);

      return response.text ?? "Unable to generate tips";
    } catch (e) {
      return "❌ Error: ${e.toString()}";
    }
  }

  /// 📝 ANALYZE TEXT - Get analysis of any text
  Future<String> analyzeText(String text, String analysisType) async {
    try {
      if (_apiKey == 'YOUR_API_KEY_HERE') {
        return "⚠️ AI API key not configured.";
      }

      final response = await _model.generateContent([
        Content.text(
          "Please provide a $analysisType of the following text:\n\n$text\n\n"
          "Keep your response concise and informative.",
        )
      ]);

      return response.text ?? "Unable to analyze text";
    } catch (e) {
      return "❌ Error: ${e.toString()}";
    }
  }

  /// 📢 GENERATE ANNOUNCEMENT - Create formatted announcements
  Future<String> generateAnnouncement(String title, String details) async {
    try {
      if (_apiKey == 'YOUR_API_KEY_HERE') {
        return "⚠️ AI API key not configured.";
      }

      final response = await _model.generateContent([
        Content.text(
          "Create a formal announcement based on:\n"
          "Title: $title\n"
          "Details: $details\n\n"
          "Format it in a professional and clear manner suitable for students.",
        )
      ]);

      return response.text ?? "Unable to generate announcement";
    } catch (e) {
      return "❌ Error: ${e.toString()}";
    }
  }

  /// 🎓 PLACEMENT TIPS - Get advice for placements
  Future<String> getPlacementTips() async {
    try {
      if (_apiKey == 'YOUR_API_KEY_HERE') {
        return "⚠️ AI API key not configured.";
      }

      final response = await _model.generateContent([
        Content.text(
          "Provide 5 practical tips for a student preparing for campus placements. "
          "Include technical preparation, soft skills, and interview tips. "
          "Format as a clear, numbered list.",
        )
      ]);

      return response.text ?? "Unable to generate tips";
    } catch (e) {
      return "❌ Error: ${e.toString()}";
    }
  }
}