import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/utils/hero.dart';
// import 'package:pyoneer/utils/color.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _formatDuration(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final formattedMilliseconds =
        (milliseconds % 1000).toString().padLeft(3, '0');

    return duration.inHours > 0
        ? '$hours:$minutes:$seconds.$formattedMilliseconds'
        : '$minutes:$seconds.$formattedMilliseconds';
  }

  @override
  Widget build(BuildContext context) {
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
                      "assets/icons/challenge_icon.png",
                      height: 50,
                    ),
                    "challenge-icon",
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
                            "Leaderboard",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          "leaderboard-title"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('challengeScore')
            .orderBy('score', descending: true)
            .orderBy('timeSpent')
            .limit(10)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล'));
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('ยังไม่มีอันดับ'));
          }

          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final doc = data[index];
              final name = doc['Name'] as String?;
              final photoUrl = doc['photoUrl'] as String?;
              final score = doc['score'] as int?;
              final timeSpent = doc['timeSpent'] as int?;

              return ListTile(
                leading: photoUrl != null
                    ? CircleAvatar(backgroundImage: NetworkImage(photoUrl))
                    : const Icon(Icons.person),
                title: Text(name ?? '-'),
                subtitle: Text(
                    'คะแนน: ${score?.toString() ?? '-'} | เวลาที่ใช้: ${timeSpent != null ? _formatDuration(timeSpent) : '-'}'),
                trailing:
                    Text('#${index + 1}', style: const TextStyle(fontSize: 20)),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.transparent,
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('challengeScore')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ListTile(
                title: Text('กำลังประมวลผล'),
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล'));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const ListTile(
                title: Text('คุณยังไม่ได้เข้าร่วม Challenge'),
              );
            }

            final doc = snapshot.data!;
            final name = doc['Name'] as String?;
            final photoUrl = doc['photoUrl'] as String?;
            final score = doc['score'] as int?;
            final timeSpent = doc['timeSpent'] as int?;

            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('challengeScore')
                  .orderBy('score', descending: true)
                  .orderBy('timeSpent')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    title: Text('Loading...'),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return const ListTile(
                    title: Text('Error loading rank'),
                  );
                }

                final data = snapshot.data!.docs;
                final userRank = data.indexWhere(
                      (doc) =>
                          doc.id == FirebaseAuth.instance.currentUser!.email,
                    ) +
                    1;

                return ListTile(
                  leading: photoUrl != null
                      ? CircleAvatar(backgroundImage: NetworkImage(photoUrl))
                      : const Icon(Icons.person),
                  title: Text(name ?? '-'),
                  subtitle: Text(
                      'คะแนน: ${score?.toString() ?? '-'} | เวลาที่ใช้: ${timeSpent != null ? _formatDuration(timeSpent) : '-'}'),
                  trailing: Text(
                    userRank > 0 ? '#$userRank' : 'Unranked',
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
