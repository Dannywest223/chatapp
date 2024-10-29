import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dannymobile/entities/message.dart';
import 'package:dannymobile/data/messages.dart';
import 'package:dannymobile/widgets/media_message.dart';
import 'package:dannymobile/widgets/text_message.dart';
import 'package:dannymobile/api_service.dart';

class ChatWithAiPage extends StatefulWidget {
  final String? voiceFilePath;

  const ChatWithAiPage({super.key, this.voiceFilePath});

  @override
  _ChatWithAiPageState createState() => _ChatWithAiPageState();
}

class _ChatWithAiPageState extends State<ChatWithAiPage> {
  final TextEditingController _messageController = TextEditingController();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final ApiService _apiService = ApiService();
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initRecorder();

    if (widget.voiceFilePath != null) {
      messages.add(Message(
        sender: MessageSender.human,
        type: MessageType.media,
        mediaUrl: widget.voiceFilePath!,
        content: '',
      ));
    }
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _messageController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        messages.add(Message(
          sender: MessageSender.human,
          type: MessageType.media,
          mediaUrl: pickedFile.path,
          content: '',
        ));
      });
      _processImage(pickedFile.path);
    }
  }

  Future<void> _startRecording() async {
    await _recorder.startRecorder(toFile: 'voice_note.aac');
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });

    if (path != null) {
      messages.add(Message(
        sender: MessageSender.human,
        type: MessageType.media,
        mediaUrl: path,
        content: '',
      ));
    }
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add(Message(
          sender: MessageSender.human,
          type: MessageType.text,
          text: messageText,
          mediaUrl: '',
          content: messageText,
        ));
        _messageController.clear();
      });
      _getAIResponse(messageText);
    }
  }

  Future<void> _getAIResponse(String input) async {
    try {
      final response = await _apiService.getResponse(input);
      setState(() {
        messages.add(Message(
          sender: MessageSender.ai,
          type: MessageType.text,
          text: response,
          mediaUrl: '',
          content: response,
        ));
      });
    } catch (error) {
      // Handle specific errors
      if (error.toString().contains('429')) {
        setState(() {
          messages.add(Message(
            sender: MessageSender.ai,
            type: MessageType.text,
            text: "Request limit exceeded. Please wait a moment and try again.",
            mediaUrl: '',
            content:
                "Request limit exceeded. Please wait a moment and try again.",
          ));
        });
      } else {
        print("Error: $error");
        // Additional error handling can be implemented here
        setState(() {
          messages.add(Message(
            sender: MessageSender.ai,
            type: MessageType.text,
            text: "Oops! Something went wrong. Please try again.",
            mediaUrl: '',
            content: "Oops! Something went wrong. Please try again.",
          ));
        });
      }
    }
  }

  void _processImage(String imagePath) {
    print("Processing image: $imagePath");
    // Implement your image processing logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat with AI Bot",
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
              // Define action for the more icon if needed
            },
            icon: const Icon(CupertinoIcons.ellipsis),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Align(
                      alignment: message.sender == MessageSender.human
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: message.type == MessageType.text
                          ? TextMessage(message: message)
                          : MediaMessage(message: message),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: messages.length,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.photo,
                      color: Colors.grey,
                    ),
                    onPressed: _pickImage,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      maxLines: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xff232729),
                        hintText: "Type your message...",
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.paperplane,
                      color: Colors.grey,
                    ),
                    onPressed: _sendMessage,
                  ),
                  IconButton(
                    icon: Icon(
                      _isRecording
                          ? CupertinoIcons.mic_fill
                          : CupertinoIcons.mic,
                      color: _isRecording ? Colors.red : Colors.grey,
                    ),
                    onPressed: _toggleRecording,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
