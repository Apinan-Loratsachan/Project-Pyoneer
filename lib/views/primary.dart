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
    // String imageUrl = '', topic = '', newsLink = '';
    var imageUrlController = TextEditingController();
    var topicController = TextEditingController();
    var newsLinkController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('เพิ่มข่าวใหม่'),
          content: Form(
            key: _formKey,
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
                if (_formKey.currentState!.validate()) {
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
              itemCount: newsItems.length > 10 ? 11 : newsItems.length + 1,
              itemBuilder: (context, index) {
                if (index < newsItems.length && index < 10) {
                  return NewsGridItem(newsItem: newsItems[index]);
                } else if (index < 10) {
                  return _buildFloatingActionButton(context);
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return UserData.uid.isNotEmpty
        ? FloatingActionButton(
            onPressed: () {
              var currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser != null) {
                showAddNewsDialog(context);
              } else {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
          )
        : const SizedBox.shrink();
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadMoreButton() {
    return ElevatedButton(
      onPressed: () async {
        if (!mounted) return;
        if (await canLaunchUrl(Uri.parse(widget.newsItem.newsLink))) {
          await launchUrl(Uri.parse(widget.newsItem.newsLink));
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cannot open link')),
            );
          }
        }
      },
      child: const Text('อ่านต่อ'),
    );
  }
}
