import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart'
    as stt; // Import speech_to_text
import 'chat_with_ai_page.dart'; // Import your ChatWithAiPage here
import 'package:dannymobile/entities/message.dart'; // Adjust based on your project structure
import 'package:dannymobile/data/messages.dart'; // Adjust based on your project structure

class SpeakToAiPage extends StatefulWidget {
  const SpeakToAiPage({super.key});

  @override
  _SpeakToAiPageState createState() => _SpeakToAiPageState();
}

class _SpeakToAiPageState extends State<SpeakToAiPage> {
  final stt.SpeechToText _speech =
      stt.SpeechToText(); // Create an instance of SpeechToText
  bool _isListening = false; // Track if the speech recognition is active
  String _recognizedText = ''; // Store the recognized text

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    // Initialize the speech recognition service
    await _speech.initialize();
  }

  void _toggleListening() async {
    if (_isListening) {
      // Stop listening if already listening
      await _speech.stop();
      setState(() {
        _isListening = false;
        _sendMessage(
            _recognizedText, MessageType.text); // Send the recognized text
        _recognizedText = ''; // Clear the recognized text
      });
    } else {
      // Start listening for speech
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _recognizedText =
                result.recognizedWords; // Update the recognized text
          });
        },
      );
    }
  }

  void _sendMessage(String content, MessageType type) {
    // Assuming you have a method to send a message
    messages.add(Message(
      sender: MessageSender.human,
      type: type,
      text: content, content: '', // Use text for sending recognized speech
    ));
    // Update your UI if necessary, e.g., by calling setState() or similar.
  }

  void _navigateToChatWithAi() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatWithAiPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Speaking to AI Bot",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("More options pressed");
            },
            icon: const Icon(CupertinoIcons.ellipsis),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Image.asset(
              'assets/pngtree-a-white-robot-with-his-blue-eyes-3d-hear-song-png-image_12592811-removebg-preview.png',
              height: 300,
            ),
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: "Describe and show me the perfect vacation spot ",
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "On an island in the ocean",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Chat Button
            Container(
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                color: Color(0xff232729),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _navigateToChatWithAi, // Navigate to ChatWithAiPage
                icon: const Icon(CupertinoIcons.chat_bubble),
                color: Colors.white,
              ),
            ),

            // Mic Button
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xff313638),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Color(0xff232729), spreadRadius: 20),
                ],
              ),
              child: IconButton(
                onPressed: _toggleListening, // Start/stop listening
                iconSize: 40,
                icon: Icon(
                  _isListening ? CupertinoIcons.mic_fill : CupertinoIcons.mic,
                  color: Colors.white,
                ),
              ),
            ),

            // More Button
            Container(
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                color: Color(0xff232729),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  print("More button pressed");
                },
                icon: const Icon(CupertinoIcons.ellipsis),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
