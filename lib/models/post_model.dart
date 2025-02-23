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

class CommentModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
