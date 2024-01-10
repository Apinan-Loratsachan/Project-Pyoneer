import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const SizedBox(width: 0),
            Image.asset(
              "assets/icons/pyoneer_snake.png",
              fit: BoxFit.cover,
              height: 50,
            ),
            const Text("หน้าหลัก"),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, pageIndex) {
                // Assuming each page has 2 rows with 3 items each
                int itemsPerPage = 6; 
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Three items per row
                    crossAxisSpacing: 10, // Add some spacing for a better look
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    // Adjust index to reflect correct item number
                    int itemNumber = pageIndex * itemsPerPage + index + 1;
                    return Card(
                      child: Center(
                        child: Text('Item $itemNumber'), // Replace with your content
                      ),
                    );
                  },
                  itemCount: itemsPerPage,
                  shrinkWrap: true,
                );
              },
              itemCount: (6 / 6).ceil(), // Adjust total item count
            ),
          ),
        ],
      ),
    );
  }
}
