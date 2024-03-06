import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/services/auth.dart';
import 'package:pyoneer/services/content_counter.dart';
import 'package:pyoneer/services/launch_url.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/hero.dart';

class LearningHubScreen extends StatefulWidget {
  const LearningHubScreen({super.key});

  @override
  State<LearningHubScreen> createState() => _LearningHubScreenState();
}

class _LearningHubScreenState extends State<LearningHubScreen>
    with AutomaticKeepAliveClientMixin {
  List<LearningResource> learningItem = [];

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

  void showAddResourceDialog(BuildContext context) {
    var imageUrlController = TextEditingController();
    var titleController = TextEditingController();
    var subtitleController = TextEditingController();
    var urlController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('เพิ่มข้อมูล'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL (https://...)',
                  ),
                  validator: (value) =>
                      value == null || !value.startsWith('https://')
                          ? 'Please enter a valid URL (https://...)'
                          : null,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter a title'
                      : null,
                ),
                TextFormField(
                  controller: subtitleController,
                  decoration: const InputDecoration(labelText: 'Subtitle'),
                ),
                TextFormField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'Resource URL (https://...)',
                  ),
                  validator: (value) =>
                      value == null || !value.startsWith('https://')
                          ? 'Please enter a valid URL (https://...)'
                          : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var resource = LearningResource(
                    imageUrl: imageUrlController.text,
                    title: titleController.text,
                    subtitle: subtitleController.text,
                    url: urlController.text,
                  );
                  Navigator.pop(context);
                  await FirebaseFirestore.instance
                      .collection('learning')
                      .add(resource.toMap());
                  await ContentCounter.getLearningItemCount();
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
                      "assets/icons/library.png",
                      height: 50,
                    ),
                    "library-icon",
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
                            "ศูนย์การเรียนรู้",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          "library-title"),
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
              future: ContentCounter.getLearningItemCount(),
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
          ),
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
                    .collection('learning')
                    .orderBy('title', descending: false)
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('ไม่มีข้อมูล'));
                  }

                  learningItem = snapshot.data!.docs
                      .map((doc) => LearningResource.fromMap(
                          doc.data() as Map<String, dynamic>))
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
                              for (int i = 0; i < learningItem.length; i++)
                                Column(
                                  children: [
                                    ListTile(
                                      minVerticalPadding: 10,
                                      leading: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.network(
                                          learningItem[i].imageUrl,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.contain,
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
                                      title: Text(
                                        learningItem[i].title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Noto Sans Thai'),
                                      ),
                                      subtitle: Text(learningItem[i].subtitle),
                                      trailing: const Icon(FontAwesomeIcons
                                          .arrowUpRightFromSquare),
                                      onTap: () {
                                        LaunchURL.launchSrtingURL(
                                            learningItem[i].url);
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
          showAddResourceDialog(context);
          ContentCounter.getNewsItemCount();
        },
        child: const Icon(Icons.add),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class LearningResource {
  String imageUrl;
  String title;
  String subtitle;
  String url;

  LearningResource({
    required this.imageUrl,
    required this.title,
    this.subtitle = '',
    required this.url,
  });

  factory LearningResource.fromMap(Map<String, dynamic> map) {
    return LearningResource(
      imageUrl: map['imageUrl'],
      title: map['title'],
      subtitle: map['subtitle'] ?? '',
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'url': url,
    };
  }
}
