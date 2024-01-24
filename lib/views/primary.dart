import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pyoneer/models/custom_cache_manager.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/views/login.dart';
import 'package:url_launcher/url_launcher.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen>
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
    String imageUrl = '', topic = '', newsLink = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('เพิ่มข่าวใหม่'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                    labelText: 'ลิงก์รูปภาพ (https://...)'),
                onChanged: (value) => imageUrl = value,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'หัวข้อข่าว (ชื่อ)'),
                onChanged: (value) => topic = value,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'ลิงก์ข่าว (https://...)'),
                onChanged: (value) => newsLink = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('เพิ่มข่าว'),
              onPressed: () {
                if (imageUrl.isNotEmpty &&
                    topic.isNotEmpty &&
                    newsLink.isNotEmpty) {
                  var newsItem = NewsItem(
                    imageUrl: imageUrl,
                    topic: topic,
                    newsLink: newsLink,
                    timestamp: DateTime.now(),
                  );
                  FirebaseFirestore.instance
                      .collection('news')
                      .add(newsItem.toMap());
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
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('news')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            newsItems = snapshot.data!.docs
                .map((doc) =>
                    NewsItem.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return GridView.builder(
              gridDelegate: SliverStairedGridDelegate(
                crossAxisSpacing: 48,
                mainAxisSpacing: 24,
                startCrossAxisDirectionReversed: true,
                pattern: [
                  const StairedGridTile(0.5, 3 / 2),
                  const StairedGridTile(0.5, 3 / 2),
                  const StairedGridTile(1.0, 3 / 2),
                ],
              ),
              itemCount: newsItems.length + 1,
              itemBuilder: (context, index) {
                if (index < newsItems.length) {
                  return NewsGridItem(newsItem: newsItems[index]);
                } else {
                  if (UserData.uid.isNotEmpty) {
                    return FloatingActionButton(
                      onPressed: () {
                        var currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser != null) {
                          showAddNewsDialog(context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const LoginScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: const Icon(Icons.add),
                    );
                  }
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class NewsItem {
  String imageUrl;
  String topic;
  String newsLink;
  DateTime? timestamp;

  NewsItem(
      {required this.imageUrl,
      required this.topic,
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
      'topic': topic,
      'newsLink': newsLink,
      'timestamp': timestamp,
    };
  }
}

class NewsGridItem extends StatefulWidget {
  final NewsItem newsItem;

  const NewsGridItem({super.key, required this.newsItem});

  @override
  _NewsGridItemState createState() => _NewsGridItemState();
}

class _NewsGridItemState extends State<NewsGridItem> {
  Color textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _updateTextColor();
  }

  Future<void> _updateTextColor() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.newsItem.imageUrl),
      size: const Size(200, 110),
    );

    if (generator.dominantColor != null) {
      textColor = generator.dominantColor!.color.computeLuminance() > 0.5
          ? Colors.black
          : Colors.white;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(widget.newsItem.newsLink))) {
          await launchUrl(Uri.parse(widget.newsItem.newsLink));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ไม่สามารถเปิดลิงก์ได้')),
          );
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: widget.newsItem.imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              cacheManager: CustomCacheManager.instance,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 5,
                ),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black.withOpacity(0.08),
                child: Text(
                  widget.newsItem.topic,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: textColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
