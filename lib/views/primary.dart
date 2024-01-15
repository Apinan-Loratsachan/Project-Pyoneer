import 'package:flutter/material.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, pageIndex) {
                  // Assuming each page has 2 rows with 3 items each
                  int itemsPerPage = 6;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Three items per row
                      crossAxisSpacing:
                          10, // Add some spacing for a better look
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      // Adjust index to reflect correct item number
                      int itemNumber = pageIndex * itemsPerPage + index + 1;
                      return Card(
                        child: Center(
                          child: Text(
                              'Item $itemNumber'), // Replace with your content
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
      ),
    );
  }
}
