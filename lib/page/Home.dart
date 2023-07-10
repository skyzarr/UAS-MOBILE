// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:doaharian/model/posts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:doaharian/widget/postCard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Posts>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://indonesia-public-static-api.vercel.app/api/heroes'));

    print(response.statusCode);
(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body) as List;
      var listPosts = getPostsData.map((i) => Posts.fromJson(i)).toList();
      return listPosts.cast<Posts>();
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  late Future<List<Posts>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,),
          child: FutureBuilder<List<Posts>>(
            future: futurePosts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var post = snapshot.data![index];
                    return Column(
                      children: [
                        PostCard(
                          posts: post,
                        ),
                        SizedBox(height: 20)
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.length,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
