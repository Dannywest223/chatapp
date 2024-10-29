import 'package:dannymobile/entities/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class MediaMessage extends StatefulWidget {
  const MediaMessage({super.key, required this.message});

  final Message message;

  @override
  _MediaMessageState createState() => _MediaMessageState();
}

class _MediaMessageState extends State<MediaMessage> {
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.openPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.closePlayer();
    super.dispose();
  }

  Future<void> _toggleAudioPlayback() async {
    if (_isPlaying) {
      await _audioPlayer.stopPlayer();
    } else {
      if (widget.message.mediaUrl != null) {
        await _audioPlayer.startPlayer(
          fromURI: widget.message.mediaUrl!,
          whenFinished: () {
            setState(() {
              _isPlaying = false;
            });
          },
        );
      }
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: size.width * 0.75,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.message.backgroundColor,
          borderRadius: widget.message.borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.message.mediaUrl != null &&
                widget.message.type == MessageType.media)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: widget.message.mediaUrl!
                        .endsWith('.aac') // Assuming audio files are AAC format
                    ? GestureDetector(
                        onTap: _toggleAudioPlayback,
                        child: Icon(
                          _isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          size: 50,
                          color: Colors.white,
                        ),
                      )
                    : Image.network(
                        widget.message.mediaUrl!,
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text('Media not found'),
                          );
                        },
                      ),
              ),
            if (widget.message.text != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.message.text!,
                  style: TextStyle(
                    color: widget.message.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
