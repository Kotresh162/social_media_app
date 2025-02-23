import 'package:dio/dio.dart';

class ApiService {
  Future<List<dynamic>> fetchPosts() async {
    try {
      var response = await Dio().get('https://jsonplaceholder.typicode.com/photos');
      if (response.statusCode == 200) {
        print("Posts fetched successfully: ${response.data.length} items");
        return response.data.take(5).toList(); // Limit to 5 posts
      } else {
        print("Error: Received status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }
}
