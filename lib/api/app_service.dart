import 'package:dio/dio.dart';
import 'package:social_media_app/models/post_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<PostModel>> fetchPosts() async {
    try {
      var response = await _dio.get('https://jsonplaceholder.typicode.com/photos');
      if (response.statusCode == 200) {
        List<PostModel> posts = (response.data as List)
            .take(5)
            .map((json) => PostModel.fromJson(json))
            .toList();
        return posts;
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
    return [];
  }

  Future<List<CommentModel>> fetchComments(int albumId) async {
    try {
      var response = await _dio.get('https://jsonplaceholder.typicode.com/comments');
      if (response.statusCode == 200) {
        List<CommentModel> comments = (response.data as List)
            .map((json) => CommentModel.fromJson(json))
            .where((comment) => comment.postId == albumId) // Match albumId with postId
            .toList();
        return comments;
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
    return [];
  }
}
