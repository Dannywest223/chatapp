import 'package:dannymobile/entities/message.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: BoxConstraints(
        maxWidth: size.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: message.backgroundColor,
        borderRadius: message.borderRadius,
      ),
      child: Text(
        message.text ?? '',
        style: TextStyle(
          color: message.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16, // Adjusted for readability
        ),
      ),
    );
  }
}
