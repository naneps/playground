import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playground/app/models/user.model.dart';

class PostContentModel {
  //
}

class PostModel {
  final String? id;
  String? title;
  String? content;
  final String? imageUrl;
  final UserModel? author;
  final String? authorId;
  final List<XFile>? images;
  final List<String>? hashtags;
  final int? views;
  final int? comments;
  final int? likes;
  final DateTime? createdAt;
  final List<String>? likedBy; // Tambahan

  PostModel({
    this.id,
    this.title,
    this.images,
    this.content,
    this.imageUrl,
    this.authorId,
    this.author,
    this.hashtags,
    this.views,
    this.comments,
    this.likes,
    this.createdAt,
    this.likedBy, // Tambahan
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return PostModel(
      id: json['id'],
      title: json['title'],
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

  //   MAKE COPY
  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    String? authorId,
    String? imageUrl,
    UserModel? author,
    List<XFile>? images,
    List<String>? hashtags,
    int? views,
    int? comments,
    int? likes,
    DateTime? createdAt,
    List<String>? likedBy,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      author: author ?? this.author,
      images: images ?? this.images,
      hashtags: hashtags ?? this.hashtags,
      views: views ?? this.views,
      authorId: authorId ?? this.authorId,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
      likedBy: likedBy ?? this.likedBy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'author': author!.toPostJson(),
      'authorId': authorId,
      'hashtags': hashtags,
      'views': views,
      'comments': comments,
      'likes': likes,
      'createdAt': createdAt,
      'likedBy': likedBy, // Tambahan
    };
  }
}
