import 'package:flutter/material.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/utils/color.dart';

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
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  // gradient: LinearGradient(
                  //     colors: [AppColor.primarSnakeColor.withAlpha(100).withOpacity(0), AppColor.secondarySnakeColor.withAlpha(100).withOpacity(1)],
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primarSnakeColor,
                      offset: Offset(0, 10),
                      blurStyle: BlurStyle.normal,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(UserData.image),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          UserData.userName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          UserData.email,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
