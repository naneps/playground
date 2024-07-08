import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerModel {
  String? uid;
  Offset? position;
  String? userId;
  bool? typing;
  String? message;

  PlayerModel({
    this.uid,
    this.position,
    this.userId,
    this.typing = false,
    this.message = '',
  });

  factory PlayerModel.fromDocument(DocumentSnapshot doc) {
    return PlayerModel(
      uid: doc['uid'],
      position: Offset(double.parse(doc['position']['dx'].toString()),
          double.parse(doc['position']['dy'].toString())),
      userId: doc['userId'],
      typing: doc['typing'],
      message: doc['message'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'position': {
        'dx': position!.dx.toDouble(),
        'dy': position!.dy.toDouble()
      },
      'userId': userId,
      'typing': typing,
      'message': message,
    };
  }
}
