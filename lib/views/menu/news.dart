import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/services/auth.dart';
import 'package:pyoneer/services/content_counter.dart';
import 'package:pyoneer/services/launch_url.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/hero.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin {
  List<NewsItem> newsItems = [];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await UserData.loadUserData();
    setState(() {});
  }

  void showAddNewsDialog(BuildContext context) {
    // String imageUrl = '', topic = '', newsLink = '';
    var imageUrlController = TextEditingController();
    var topicController = TextEditingController();
    var newsLinkController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('เพิ่มข่าวใหม่'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(
                      labelText: 'ลิงก์รูปภาพ (https://...)'),
                  validator: (value) =>
                      value == null || !value.startsWith('https://')
                          ? 'กรุณาใส่ลิงก์ที่ถูกต้อง (https://...)'
                          : null,
                ),
                TextFormField(
                  controller: topicController,
                  decoration:
                      const InputDecoration(labelText: 'หัวข้อข่าว (ชื่อ)'),
                  validator: (value) => value == null ||
                          value.trim() == ' ' ||
                          value.trim().isEmpty
                      ? 'กรุณาใส่หัวข้อข่าว'
                      : null,
                ),
                TextFormField(
                  controller: newsLinkController,
                  decoration: const InputDecoration(
                      labelText: 'ลิงก์ข่าว (https://...)'),
                  validator: (value) =>
                      value == null || !value.startsWith('https://')
                          ? 'กรุณาใส่ลิงก์ที่ถูกต้อง (https://...)'
                          : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('เพิ่มข่าว'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var newsItem = NewsItem(
                    imageUrl: imageUrlController.text,
                    topic: topicController.text.isNotEmpty
                        ? topicController.text
                        : null,
                    newsLink: newsLinkController.text,
                    timestamp: DateTime.now(),
                  );
                  Navigator.pop(context);
                  await FirebaseFirestore.instance
                      .collection('news')
                      .add(newsItem.toMap());
                  await ContentCounter.getNewsItemCount();
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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PyoneerHero.hero(
                    Image.asset(
                      "assets/icons/news.png",
                      height: 50,
                    ),
                    "news-icon",
                  ),
                  Column(
                    children: [
                      Hero(
                        tag: "pyoneer_text-title",
                        child: Image.asset(
                          "assets/icons/pyoneer_text.png",
                          fit: BoxFit.cover,
                          height: 60,
                        ),
                      ),
                      PyoneerHero.hero(
                          const Text(
                            "ข่าวที่น่าสนใจ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          "news-title"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<int>(
              future: ContentCounter.getNewsItemCount(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // Handle error case
                    return const Text('0 รายการ');
                  }

                  // Display the news count as a string in the trailing
                  return PyoneerHero.hero(
                    Text(
                      '${snapshot.data} รายการ',
                      style: const TextStyle(fontSize: 12),
                    ),
                    "news-counter",
                  );
                } else {
                  // Display a loading indicator while waiting for the data
                  return const CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('news')
                    .orderBy('timestamp', descending: true)
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('ไม่พบข่าว'));
                  }

                  newsItems = snapshot.data!.docs
                      .map((doc) =>
                          NewsItem.fromMap(doc.data() as Map<String, dynamic>))
                      .toList();

                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i < newsItems.length; i++)
                                Column(
                                  children: [
                                    ListTile(
                                      minVerticalPadding: 10,
                                      leading: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.network(
                                          newsItems[i].imageUrl,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const SizedBox(
                                              width: 100,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.error);
                                          },
                                        ),
                                      ),
                                      title: Text(newsItems[i].topic!),
                                      titleTextStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Noto Sans Thai'),
                                      onTap: () {
                                        LaunchURL.launchSrtingURL(
                                            newsItems[i].newsLink);
                                      },
                                    ),
                                    const SizedBox(height: 10)
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
              const SizedBox(height: 55)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && Auth.adminUIDs.contains(currentUser.uid)) {
      return FloatingActionButton(
        onPressed: () {
          showAddNewsDialog(context);
          ContentCounter.getNewsItemCount();
        },
        child: const Icon(Icons.add),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class NewsItem {
  String imageUrl;
  String? topic;
  String newsLink;
  DateTime? timestamp;

  NewsItem(
      {required this.imageUrl,
      this.topic,
      required this.newsLink,
      this.timestamp});

  factory NewsItem.fromMap(Map<String, dynamic> map) {
    return NewsItem(
      imageUrl: map['imageUrl'],
      topic: map['topic'],
      newsLink: map['newsLink'],
      timestamp: map['timestamp']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'topic': topic ?? "",
      'newsLink': newsLink,
      'timestamp': timestamp,
    };
  }
}
