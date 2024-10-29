import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/premium_plan_card.dart'; // Ensure the correct import
import '../widgets/Idea_card.dart'; // Ensure this import is correct
import 'chat_with_ai_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20), // Padding can remain const
          children: [
            const PremiumPlanCard(), // Keep const here
            const SizedBox(height: 20), // const can remain for SizedBox

            // Correcting IdealCard to IdeaCard (assuming this is a typo)
            const Row(
              children: [
                IdealCard(
                  // Ensure you have this correctly named in your widgets
                  icon: CupertinoIcons.location_solid,
                  text: "Generate ideas and write article",
                ),
                SizedBox(width: 10),
                IdealCard(
                  icon: CupertinoIcons.photo_fill,
                  text: "Generate pictures and arts",
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              "History",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Wrap(
              runSpacing: 14,
              children: List.generate(
                8,
                (index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatWithAiPage(),
                        ),
                      );
                    },
                    title: const Text(
                      "Hey there, subscribe to this awesome channel if you want more content like this",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: const Icon(CupertinoIcons.chat_bubble_2_fill),
                    trailing: const Icon(CupertinoIcons.arrow_right),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
