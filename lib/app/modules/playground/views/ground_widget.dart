import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/player.model.dart';
import 'package:playground/app/services/user_service_information.dart';

class AnimationConfig {
  int frame;
  String name;
  String path;
  double stepTime;

  AnimationConfig({
    required this.frame,
    required this.name,
    required this.path,
    this.stepTime = 0.1,
  });

  List<String> get fullPaths {
    return List.generate(frame, (index) {
      return '$path/${name}_${index + 1}.png';
    });
  }
}

class GroundWidget extends FlameGame with HasKeyboardHandlerComponents {
  late AnimationConfig walkAnimation;
  late AnimationConfig idleAnimation;
  List<PlayerModel> players;
  String roomId;
  late StreamSubscription playersSubscription;
  Player? mainPlayer; // Add a reference to the main player

  GroundWidget({
    required this.roomId,
    this.players = const [],
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    walkAnimation = AnimationConfig(frame: 10, name: 'Walk', path: 'dino');
    idleAnimation = AnimationConfig(frame: 10, name: 'Idle', path: 'dino');
    List<Sprite> walkSprites = [];
    for (String path in walkAnimation.fullPaths) {
      walkSprites.add(Sprite(await images.load(path)));
    }

    final walkAnimationSprites = SpriteAnimation.spriteList(
      walkSprites,
      stepTime: walkAnimation.stepTime,
    );

    List<Sprite> idleSprites = [];
    for (String path in idleAnimation.fullPaths) {
      idleSprites.add(Sprite(await images.load(path)));
    }

    final idleAnimationSprites = SpriteAnimation.spriteList(
      idleSprites,
      stepTime: idleAnimation.stepTime,
    );

    for (var player in players) {
      final playerComponent = Player(
        walkAnimation: walkAnimationSprites,
        idleAnimation: idleAnimationSprites,
        position: Vector2(player.position!.dx, player.position!.dy),
        size: Vector2(60, 60),
        roomId: roomId,
        playerId: player.userId!,
      );

      add(playerComponent);

      if (player.userId == Get.find<UserService>().uid) {
        mainPlayer = playerComponent; // Initialize the main player
      }
    }

    _listenForPlayerUpdates();
  }

  @override
  void onRemove() {
    playersSubscription.cancel();
    super.onRemove();
  }

  void _listenForPlayerUpdates() {
    playersSubscription = FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('players')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final player = players.firstWhere((p) => p.userId == doc.id);
        final newPosition = data['position'] as Map<String, dynamic>;
        player.position = Offset(newPosition['dx'], newPosition['dy']);
      }
    });
  }
}

class Player extends SpriteAnimationComponent with KeyboardHandler {
  final double speed = 150;
  Vector2 direction = Vector2.zero();
  late SpriteAnimation idleAnimation;
  late SpriteAnimation walkAnimation;
  final String roomId;
  final String playerId;

  Player({
    required this.walkAnimation,
    required this.idleAnimation,
    required Vector2 position,
    required Vector2 size,
    required this.roomId,
    required this.playerId,
  }) : super(animation: idleAnimation, position: position, size: size);

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    Vector2 newDirection = Vector2.zero();

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      newDirection += Vector2(0, -1);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      newDirection += Vector2(0, 1);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      newDirection += Vector2(-1, 0);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      newDirection += Vector2(1, 0);
    }

    updateDirection(newDirection);
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direction * speed * dt;

    // Update position in Firebase
    _updatePositionInFirebase();
  }

  void updateDirection(Vector2 newDirection) {
    direction = newDirection;

    if (direction.length > 0.0) {
      animation = walkAnimation;
    } else {
      animation = idleAnimation;
    }

    direction.normalize();
  }

  void _updatePositionInFirebase() {
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('players')
        .doc(playerId)
        .update({
      'position': {'dx': position.x, 'dy': position.y}
    });
  }
}
