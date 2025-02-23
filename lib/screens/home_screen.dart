import 'package:flutter/material.dart';
import 'package:social_media_app/api/app_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> posts = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    List<dynamic> fetchedPosts = await apiService.fetchPosts();
    setState(() {
      posts = fetchedPosts;
    });
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
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
          const SizedBox(height: 10),
          Expanded(
            child: posts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Get.to(() => PostScreen(post: posts[index]));
                          print("oprned the card");
                        },
                        child: _buildPostCard(posts[index]),
                      );
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
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('User ${post['albumId']}'),
            subtitle: const Text('2 hours ago'),
            trailing: const Icon(Icons.more_vert),
          ),
          Image.network(
            post['url'],
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey[300], // Placeholder background
                child: const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              );
            },
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
