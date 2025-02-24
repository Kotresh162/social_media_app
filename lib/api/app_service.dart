import 'dart:async';
import 'package:dio/dio.dart';
import 'package:social_media_app/models/comment_model.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/user_model.dart';

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
  
  Future<UserModel> fetchUserDetails(int id) async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users/$id');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      throw Exception('Error fetching user details: $e');
    }
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
