import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playground/app/models/user.model.dart';

class PostModel {
  final String id;
  final String content;
  final String imageUrl;
  final UserModel author;
  final List<String> hashtags;
  final int views;
  final int comments;
  final int likes;
  final DateTime createdAt;
  final List<String> likedBy; // Tambahan

  PostModel({
    required this.id,
    required this.content,
    required this.imageUrl,
    required this.author,
    required this.hashtags,
    required this.views,
    required this.comments,
    required this.likes,
    required this.createdAt,
    required this.likedBy, // Tambahan
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      author: UserModel.fromJson(json['author']),
      hashtags: List<String>.from(json['hashtags']),
      views: json['views'],
      comments: json['comments'],
      likes: json['likes'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      likedBy: json['likedBy'] != null
          ? List<String>.from(json['likedBy'])
          : [], // Tambahan
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'imageUrl': imageUrl,
      'author': author.toPostJson(),
      'hashtags': hashtags,
      'views': views,
      'comments': comments,
      'likes': likes,
      'createdAt': createdAt,
      'likedBy': likedBy, // Tambahan
    };
  }
}
