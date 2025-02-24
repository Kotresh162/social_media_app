import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/api/app_service.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/screens/post_screen.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> posts = [];
  final ApiService apiService = ApiService();

  final MainController controller = Get.put(MainController());

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
                          Get.to(() => PostScreen(post: posts[index]));
                          print("Opened the card");
                        },
                        child: _buildPostCard(posts[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          )),
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

  Widget _buildPostCard(PostModel post) {
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
            title: Text('User ${post.id}'),
            subtitle: const Text('2 hours ago'),
            trailing: const Icon(Icons.more_vert),
          ),
          // Handle image loading failure
          Image.network(
            post.imageUrl,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child; // Image loaded, show the image
              } else {
                return Container(
                  color: Colors.grey, // Grey background for loading error
                  height: 250,
                  width: double.infinity,
                  child: const Center(
                    child: Icon(Icons.image, color: Colors.white), // Optional icon for visual feedback
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey, // Grey background for error
                height: 250,
                width: double.infinity,
                child: const Center(
                  child: Icon(Icons.image, color: Colors.white), // Optional icon for visual feedback
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              post.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
