import 'package:flutter/material.dart';
import 'post.dart';
import 'dio_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const _title = 'Surf Flutter Course: Dio (module 10)';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    testNetworkCall();
    super.initState();
  }

  void testNetworkCall() async {
    final newPost = await createPost();
    final response = await getPosts();
    final postsList = parsePosts(response);

    print('Response HTTP call = $response');
    print('postList = $postsList');
  }

  List<Post> parsePosts(List<dynamic> posts) {
    List<Post> postFromResponse = [];

    for (final post in posts) {
      postFromResponse.add(
        Post.fromJson(post),
      );
    }

    return postFromResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(),
    );
  }
}
