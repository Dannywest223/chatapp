import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Your Hugging Face API key
  final String _apiKey =
      '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'; // Replace with your API key

  // API endpoint for the model you are using
  final String _apiUrl =
      'https://api-inference.huggingface.co/models/gpt2'; // Replace 'gpt2' with your model

  Future<String> getResponse(String question) async {
    final body = jsonEncode({"inputs": question});

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Authorization": "Bearer $_apiKey",
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data[0]
            ['generated_text']; // Adjust based on the response structure
      } else {
        return "Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      return "Failed to connect: $e";
    }
  }
}
