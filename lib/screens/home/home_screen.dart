import 'package:enva/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentChoice = 'Upcoming';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 80,
          title: InkWell(
            onTap: () {
              final RenderBox button = context.findRenderObject() as RenderBox;
              final Offset offset = button.localToGlobal(Offset.zero);

              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(0, offset.dy + 90, 0, 0),
                items: [
                  PopupMenuItem<String>(
                    value: 'Upcoming',
                    child: Row(
                      children: [
                        const Text('Upcoming'),
                        const Spacer(),
                        Icon(Icons.event, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Past Events',
                    child: Row(
                      children: [
                        const Text('Past Events'),
                        const Spacer(),
                        Icon(Icons.history, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Drafts',
                    child: Row(
                      children: [
                        const Text('Drafts'),
                        const Spacer(),
                        Icon(Icons.edit, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Hostings',
                    child: Row(
                      children: [
                        const Text('Hostings'),
                        const Spacer(),
                        Icon(Icons.home, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Attending',
                    child: Row(
                      children: [
                        const Text('Attending'),
                        const Spacer(),
                        Icon(Icons.check_circle, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  setState(() {
                    currentChoice = value;
                  });
                }
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentChoice,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  // TODO: Add event functionality
                },
              ),
            ),
            // Profile Button
            Container(
              margin: const EdgeInsets.only(right: 16, left: 6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Selection: $currentChoice',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
