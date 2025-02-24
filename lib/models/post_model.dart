import 'package:social_media_app/models/comment_model.dart';

class PostModel {
  final int albumId;
  final int id;
  final String title;
  final String imageUrl;
  final String thumbnailUrl;
  final List<CommentModel> comments;

  PostModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      imageUrl: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
      comments: [],
    );
  }
}
