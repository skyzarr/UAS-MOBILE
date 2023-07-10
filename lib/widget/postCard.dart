// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:doaharian/model/posts.dart';
import 'package:doaharian/page/detailPage.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.posts}) : super(key: key);
  final Posts posts;

  // const PostCard({required this.posts});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return DetailPage(posts: posts);
            }),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(posts.id.toString()),
            Text(
              posts.title as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(posts.body as String),
          ],
        ),
      ),
    );
  }
}