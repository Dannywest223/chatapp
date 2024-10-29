import 'package:flutter/material.dart';

enum MessageType { text, media }

enum MessageSender { bot, human, ai }

class Message {
  final MessageType type; // Type of message (text or media)
  final MessageSender sender; // Sender of the message (bot, human, or AI)
  final String? text; // Text content for text messages
  final String? mediaUrl; // URL for media messages (like audio or images)
  final String content; // Content field to hold message content

  const Message({
    required this.type,
    required this.sender,
    this.text,
    this.mediaUrl,
    required this.content, // Added content as a required parameter
  });
}

extension MessageExtension on Message {
  // Get text color based on sender
  Color get textColor {
    switch (sender) {
      case MessageSender.bot:
        return Colors.white;
      case MessageSender.human:
        return const Color(0xFF232729);
      case MessageSender.ai:
        return Colors.black; // Color for AI messages
      default:
        return Colors.black; // Fallback color
    }
  }

  // Get background color based on sender
  Color get backgroundColor {
    switch (sender) {
      case MessageSender.bot:
        return const Color(0xFF232729);
      case MessageSender.human:
        return const Color(0xFF7dd4fb);
      case MessageSender.ai:
        return const Color(0xFFE0E0E0); // Background color for AI
      default:
        return Colors.white; // Fallback color
    }
  }

  // Define the border radius for the message bubble
  BorderRadius get borderRadius {
    return const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(18),
    );
  }
}
