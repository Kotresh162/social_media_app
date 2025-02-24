import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/api/app_service.dart';
import 'package:social_media_app/models/comment_model.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/screens/user_screen.dart';

class PostScreen extends StatefulWidget {
  final PostModel post;

  const PostScreen({super.key, required this.post});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ApiService _apiService = ApiService();
  List<CommentModel> comments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  Future<void> loadComments() async {
    List<CommentModel> fetchedComments = await _apiService.fetchComments(widget.post.albumId);
    setState(() {
      comments = fetchedComments;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Details")),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => UserScreen(id: widget.post.id));
              print("card printed");
            },
            child: Container(
              height: 500,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 111, 110, 110), width: 1),
                image: DecorationImage(
                  image: NetworkImage(widget.post.imageUrl),
                  fit: BoxFit.cover,
                  onError: (_, __) => const Icon(Icons.image, color: Color.fromARGB(255, 28, 28, 28)),
                ),
              ),
              child: widget.post.imageUrl.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.post.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Comments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : comments.isEmpty
                    ? const Center(child: Text("No comments available"))
                    : ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            title: Text(comment.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(comment.body),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
