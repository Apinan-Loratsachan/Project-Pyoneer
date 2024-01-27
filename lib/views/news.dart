import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pyoneer/models/custom_cache_manager.dart';
import 'package:pyoneer/service/content_counter.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/utils/hero.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var newsItem = NewsItem(
                    imageUrl: imageUrlController.text,
                    topic: topicController.text.isNotEmpty
                        ? topicController.text
                        : null,
                    newsLink: newsLinkController.text,
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
            child: PyoneerHero.hero(
              Text("${ContentCounter.newsCounter} รายการ"),
              "news-counter",
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('news')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No news available'));
                  }

                  newsItems = snapshot.data!.docs
                      .map((doc) =>
                          NewsItem.fromMap(doc.data() as Map<String, dynamic>))
                      .toList();

                  // return GridView.builder(
                  //   gridDelegate: SliverStairedGridDelegate(
                  //     crossAxisSpacing: 48,
                  //     mainAxisSpacing: 24,
                  //     startCrossAxisDirectionReversed: true,
                  //     pattern: [
                  //       // แก้ขนาดตรงนี้
                  //       const StairedGridTile(0.5, 6 / 5),
                  //       const StairedGridTile(0.5, 6 / 5),
                  //       const StairedGridTile(0.9, 8 / 4.4),
                  //       const StairedGridTile(0.5, 6 / 4),
                  //       const StairedGridTile(0.5, 6 / 3.2),
                  //       const StairedGridTile(0.5, 16 / 9),
                  //       const StairedGridTile(0.5, 5 / 3),
                  //       const StairedGridTile(0.9, 8 / 4.4),
                  //       const StairedGridTile(0.5, 8 / 4.6),
                  //       const StairedGridTile(0.5, 3 / 2),
                  //     ],
                  //   ),
                  //   itemCount: newsItems.length > 10 ? 11 : newsItems.length + 1,
                  //   itemBuilder: (context, index) {
                  //     if (index < newsItems.length && index < 10) {
                  //       return NewsGridItem(newsItem: newsItems[index]);
                  //     } else if (index < 10) {
                  //       return _buildFloatingActionButton(context);
                  //     } else {
                  //       return const SizedBox.shrink();
                  //     }
                  //   },
                  // );

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
                                      leading: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.network(
                                          newsItems[i].imageUrl,
                                          width: 100,
                                        ),
                                      ),
                                      title: Text(newsItems[i].topic!),
                                      titleTextStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Noto Sans Thai'
                                      ),
                                      onTap: () {
                                        _launchURL(newsItems[i].newsLink);
                                      },
                                    ),
                                    // if (i < newsItems.length - 1) PyoneerText.divider(15)
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
    const List<String> allowedUIDs = [
      '3XlCZTQFqTScyYE0YBz94MJlORs1',
      'A0ILxjzDZeQk2okmGUcs85kMCSh2',
      'wA2YJSiuLAQXMZH77esSNHmSVYI2',
      'fLzQpFJOKVYLrRfcNLKoFqBLOZp1'
    ];

    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && allowedUIDs.contains(currentUser.uid)) {
      return FloatingActionButton(
        onPressed: () {
          showAddNewsDialog(context);
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

class NewsGridItem extends StatefulWidget {
  final NewsItem newsItem;

  const NewsGridItem({super.key, required this.newsItem});

  @override
  // ignore: library_private_types_in_public_api
  _NewsGridItemState createState() => _NewsGridItemState();
}

class _NewsGridItemState extends State<NewsGridItem>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Color textColor = Colors.white;
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  bool isTopicVisible = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _updateTextColor();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero)
            .animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.ease,
    ));

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
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
    super.build(context);
    return FadeTransition(
      opacity: _fadeAnimation!,
      child: SlideTransition(
        position: _slideAnimation!,
        child: GestureDetector(
          onTap: () async {
            setState(() {
              isTopicVisible = !isTopicVisible;
            });
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
                if (isTopicVisible)
                  const Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: isTopicVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      color: Colors.black.withOpacity(0.7),
                      child: Center(
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: widget.newsItem.topic?.isEmpty ?? true
                              ? Center(
                                  child: _buildReadMoreButton(),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.newsItem.topic ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildReadMoreButton(),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadMoreButton() {
    return ElevatedButton(
      onPressed: isTopicVisible
          ? () async {
              if (!mounted) return;
              if (await canLaunchUrl(Uri.parse(widget.newsItem.newsLink))) {
                await launchUrl(Uri.parse(widget.newsItem.newsLink));
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ไม่สามารถเปิดลิงก์ได้')),
                  );
                }
              }
            }
          : null,
      child: const Text('อ่านต่อ'),
    );
  }
}

// Function to launch URL
void _launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}
