import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playground/app/models/user.model.dart';

class PostModel {
  String? id;
  String? content;
  String? imageUrl;
  UserModel? author;
  List<String>? hashtags;
  int? views;
  int? comments;
  int? likes;
  DateTime? createdAt;

  PostModel({
    this.id,
    this.content,
    this.imageUrl,
    this.author,
    this.hashtags,
    this.views,
    this.comments,
    this.likes,
    this.createdAt,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    imageUrl = json['imageUrl'];
    author = json['author'] != null ? UserModel.fromJson(json['author']) : null;
    hashtags =
        json['hashtags'] != null ? List<String>.from(json['hashtags']) : [];
    views = json['views'];
    comments = json['comments'];
    likes = json['likes'];
    createdAt = (json['createdAt'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['hashtags'] = hashtags;
    data['views'] = views;
    data['comments'] = comments;
    data['likes'] = likes;
    data['createdAt'] = createdAt;
    return data;
  }
}
