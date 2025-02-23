import 'package:enva/screens/screens.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class EventCard {
  final String title;
  final String date;
  final String location;
  final String imageUrl;

  EventCard({
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentChoice = 'Upcoming';
  final PageController _pageController = PageController(viewportFraction: 0.9);

  final List<EventCard> events = [
    EventCard(
      title: 'Summer Music Festival',
      date: '15 March 2024',
      location: 'Central Park',
      imageUrl: 'assets/frieren.jpg',
    ),
    EventCard(
      title: 'Tech Conference 2024',
      date: '20 March 2024',
      location: 'Convention Center',
      imageUrl: 'assets/frieren.jpg',
    ),
    EventCard(
      title: 'Food & Wine Expo',
      date: '25 March 2024',
      location: 'City Hall',
      imageUrl: 'assets/frieren.jpg',
    ),
  ];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Current Selection: $currentChoice',
          //     style: const TextStyle(color: Colors.white, fontSize: 16),
          //   ),
          // ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          events[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Blurred Overlay at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: MediaQuery.of(context).size.height *
                            0.15, // Increased height for smoother gradient
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(0),
                          ),
                          child: BackdropFilter(
                            blendMode: BlendMode.srcOver,
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.0, 0.2, 0.8, 1.0],
                                  colors: [
                                    Colors.black.withOpacity(0.0),
                                    Colors.black.withOpacity(0.2),
                                    Colors.black.withOpacity(0.4),
                                    Colors.black.withOpacity(0.6),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              events[index].title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8,
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  events[index].date,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8,
                                        color: Colors.black,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    events[index].location,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 8,
                                          color: Colors.black,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
