class PostModel {
  String? id;
  String? authorId;
  String? content;
  DateTime? timestamp;
  List<String>? tags;
  int? likes;
  int? commentsCount;

  PostModel({
    this.id,
    this.authorId,
    this.content,
    this.timestamp,
    this.tags,
    this.likes = 0,
    this.commentsCount = 0,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['authorId'];
    content = json['content'];
    timestamp = DateTime.parse(json['timestamp']);
    tags = List<String>.from(json['tags']);
    likes = json['likes'] ?? 0;
    commentsCount = json['commentsCount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['authorId'] = authorId;
    data['content'] = content;
    data['timestamp'] = timestamp!.toIso8601String();
    data['tags'] = tags;
    data['likes'] = likes;
    data['commentsCount'] = commentsCount;
    return data;
  }
}
