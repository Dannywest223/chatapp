import 'package:dannymobile/entities/message.dart';

List<Message> messages = [
  const Message(
    type: MessageType.text,
    sender: MessageSender.human,
    text:
        "Describes and show me the perfect vacation spot on an island in the ocean",
    mediaUrl: '', // No media for text messages
    content:
        "Describes and show me the perfect vacation spot on an island in the ocean", // Added content
  ),
  const Message(
    type: MessageType.media,
    sender: MessageSender.bot,
    mediaUrl:
        "https://images.unsplash.com/photo-1520454974749-611b7248ffdb?q=80&w=3648&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3w",
    text:
        "Imagine yourself on an idyllic island in the middle of the vast ocean, where turquoise waters and powdery white sand surround you. This perfect vacation spot is a tropical paradise that offers a blend of tranquility and adventure.",
    content:
        "Imagine yourself on an idyllic island in the middle of the vast ocean, where turquoise waters and powdery white sand surround you. This perfect vacation spot is a tropical paradise that offers a blend of tranquility and adventure.", // Added content
  ),
];
