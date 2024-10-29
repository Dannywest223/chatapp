import 'package:dannymobile/pages/speak_to_ai_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IdealCard extends StatelessWidget {
  const IdealCard({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: SizedBox(
        height: 165,
        child: Card.filled(
          clipBehavior: Clip.hardEdge,
          color: const Color(0xff232729),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SpeakToAiPage(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFF313638),
                    child: Icon(icon, color: CupertinoColors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
