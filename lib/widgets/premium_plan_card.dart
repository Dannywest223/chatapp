import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PremiumPlanCard extends StatelessWidget {
  const PremiumPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align the row items at the start
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DannyWest App",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Harness The Full Power of AI within Our App",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Define the action for upgrading
                    },
                    icon: const Icon(CupertinoIcons.bolt_fill),
                    label: const Text("Upgrade now"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Text color
                      backgroundColor:
                          Colors.black, // Button color set to black
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Image.asset(
                'assets/pngtree-a-white-robot-with-his-blue-eyes-3d-hear-song-png-image_12592811-removebg-preview.png',
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
