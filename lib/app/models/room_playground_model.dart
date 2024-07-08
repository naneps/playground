import 'package:get/get.dart';

class MessageModel {
  String? senderId;
  String? content;
  DateTime? timestamp;

  MessageModel({
    this.senderId,
    this.content,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  static MessageModel fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      content: map['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}

class RoomPlayGroundModel {
  String? id;
  String? name;
  String? description;
  String? authorId;
  RxList<String>? userIds;
  RxList<MessageModel>? messages;

  RoomPlayGroundModel({
    this.id,
    this.name,
    this.description,
    this.authorId,
    userIds,
    messages,
  })  : userIds = userIds ?? <String>[].obs,
        messages = messages ?? <MessageModel>[].obs;

  RoomPlayGroundModel copyWith({
    String? id,
    String? name,
    String? description,
    String? authorId,
    RxList<String>? userIds,
    RxList<MessageModel>? messages,
  }) {
    return RoomPlayGroundModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      authorId: authorId ?? this.authorId,
      userIds: userIds ?? this.userIds,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'authorId': authorId,
      'userIds': userIds?.toList() ?? <String>[],
      'messages': messages?.map((message) => message.toMap()).toList(),
      'createdAt': DateTime.now(),
    };
  }

  static RoomPlayGroundModel fromMap(Map<String, dynamic> map) {
    return RoomPlayGroundModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      userIds: RxList<String>.from(map['userIds']),
      messages: RxList<MessageModel>.from(
        (map['messages'] as List)
            .map((message) => MessageModel.fromMap(message)),
      ),
    );
  }
}
