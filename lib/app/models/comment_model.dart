class CommentModel {
  String? id;
  String? comment;
  String? userId;
  String? postId;
  String? createdAt;
  String? updatedAt;

  CommentModel(
      {this.id,
      this.comment,
      this.userId,
      this.postId,
      this.createdAt,
      this.updatedAt});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json['id'],
        comment: json['comment'],
        userId: json['user_id'],
        postId: json['post_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
