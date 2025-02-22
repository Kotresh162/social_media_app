import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      var response = await Dio().get('https://jsonplaceholder.typicode.com/photos');
      if (response.statusCode == 200) {
        print("Posts fetched successfully: ${response.data.length} items");
        setState(() {
          posts = response.data.take(15).toList(); // Limit to 15 posts
        });
      } else {
        print("Error: Received status code ${response.statusCode}");
      }
    } catch (e) {
      print('Error fetching posts: $e');
      setState(() {
        posts = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connections',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {

          }, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: Column(
        children: [
          // User Stories Section
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildStoryCircle('You'),
                _buildStoryCircle('mariio5'),
                _buildStoryCircle('lea.98'),
                _buildStoryCircle('loco_cafe'),
                _buildStoryCircle('gabriel.g'),
              ],
            ),
          ),

          // User Posts Section
          Expanded(
            child: posts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return _buildPostCard(posts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCircle(String username) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: Text(username[0], style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 5),
          Text(username, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPostCard(dynamic post) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('User ${post['albumId']}'), // Using albumId as user reference
            subtitle: const Text('2 hours ago'),
            trailing: const Icon(Icons.more_vert),
          ),
          Image.network(
            post['url'], // Fetching post image
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.comment, size: 18),
                        SizedBox(width: 5),
                        Text('20 comments'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red, size: 18),
                        SizedBox(width: 5),
                        Text('300 likes'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
