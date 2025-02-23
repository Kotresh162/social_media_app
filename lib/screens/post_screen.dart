import 'package:flutter/material.dart';
import 'package:social_media_app/api/app_service.dart';
import 'package:social_media_app/models/post_model.dart';

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
      appBar: AppBar(title: Text("Post Details")),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.post.imageUrl,
                  // Placeholder or fallback image if URL fails
                  scale: 1.0,
                ),
                fit: BoxFit.cover,
                onError: (_, __) => const AssetImage('assets/placeholder.jpg'),
              ),
            ),
            child: widget.post.imageUrl.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : null,
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
