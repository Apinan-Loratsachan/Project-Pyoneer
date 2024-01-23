import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  List<NewsItem> newsItems = [];

  void showAddNewsDialog(BuildContext context) {
    String imageUrl = '', topic = '', newsLink = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add News'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                onChanged: (value) => imageUrl = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Topic'),
                onChanged: (value) => topic = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'News Link'),
                onChanged: (value) => newsLink = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (imageUrl.isNotEmpty &&
                    topic.isNotEmpty &&
                    newsLink.isNotEmpty) {
                  setState(() {
                    newsItems.add(NewsItem(
                        imageUrl: imageUrl, topic: topic, newsLink: newsLink));
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.custom(
          gridDelegate: SliverStairedGridDelegate(
            crossAxisSpacing: 48,
            mainAxisSpacing: 24,
            startCrossAxisDirectionReversed: true,
            pattern: [
              const StairedGridTile(0.5, 1),
              const StairedGridTile(0.5, 3 / 4),
              const StairedGridTile(1.0, 10 / 4),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < newsItems.length) {
                return NewsGridItem(newsItem: newsItems[index]);
              } else {
                return FloatingActionButton(
                  onPressed: () => showAddNewsDialog(context),
                  child: const Icon(Icons.add),
                );
              }
            },
            childCount: newsItems.length + 1,
          ),
        ),
      ),
    );
  }
}

class NewsItem {
  String imageUrl;
  String topic;
  String newsLink;

  NewsItem(
      {required this.imageUrl, required this.topic, required this.newsLink});
}

class NewsGridItem extends StatelessWidget {
  final NewsItem newsItem;

  const NewsGridItem({Key? key, required this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement the action to open the news link
      },
      child: Card(
        child: Column(
          children: [
            Image.network(newsItem.imageUrl), // Display the news image
            Text(newsItem.topic), // Display the news topic
          ],
        ),
      ),
    );
  }
}
