import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

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

  @override
  Future<void> onLoad() async {
    super.onLoad();

    walkAnimation = AnimationConfig(
      frame: 10, // Sesuaikan dengan jumlah frame animasi berjalan
      name: 'Walk',
      path: 'dino',
    );

    idleAnimation = AnimationConfig(
      frame: 10, // Sesuaikan dengan jumlah frame animasi diam
      name: 'Idle',
      path: 'dino',
    );

    // Muat semua gambar yang dibutuhkan untuk animasi berjalan
    List<Sprite> walkSprites = [];
    for (String path in walkAnimation.fullPaths) {
      walkSprites.add(Sprite(await images.load(path)));
    }

    // Buat animasi berjalan dari daftar sprite
    final walkAnimationSprites = SpriteAnimation.spriteList(
      walkSprites,
      stepTime: walkAnimation.stepTime,
    );

    // Muat semua gambar yang dibutuhkan untuk animasi diam
    List<Sprite> idleSprites = [];
    for (String path in idleAnimation.fullPaths) {
      idleSprites.add(Sprite(await images.load(path)));
    }

    // Buat animasi diam dari daftar sprite
    final idleAnimationSprites = SpriteAnimation.spriteList(
      idleSprites,
      stepTime: idleAnimation.stepTime,
    );

    // Tambahkan beberapa pemain dengan animasi yang berbeda
    add(
      Player(
        idleAnimation: idleAnimationSprites,
        walkAnimation: walkAnimationSprites,
        position: Vector2(100, 100),
        size: Vector2(64, 64),
      ),
    );
    add(Player(
      idleAnimation: idleAnimationSprites,
      walkAnimation: walkAnimationSprites,
      position: Vector2(200, 100),
      size: Vector2(64, 64),
    ));
  }
}

class Player extends SpriteAnimationComponent with KeyboardHandler {
  final double speed = 100; // Kecepatan karakter berjalan (piksel per detik)
  Vector2 direction = Vector2.zero(); // Arah pergerakan
  late SpriteAnimation idleAnimation; // Animasi diam
  late SpriteAnimation walkAnimation; // Animasi berjalan

  Player({
    required this.walkAnimation,
    required this.idleAnimation,
    required Vector2 position,
    required Vector2 size,
  }) : super(animation: idleAnimation, position: position, size: size);

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    direction = Vector2.zero(); // Reset arah

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      direction += Vector2(0, -1);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      direction += Vector2(0, 1);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      direction += Vector2(-1, 0);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      direction += Vector2(1, 0);
    }

    direction.normalize(); // Normalisasi arah agar tidak lebih dari 1 unit

    // Pilih animasi berjalan atau diam berdasarkan arah karakter
    if (direction.length > 0.0) {
      animation = walkAnimation; // Gunakan walkAnimation jika ada input arah
    } else {
      animation =
          idleAnimation; // Gunakan idleAnimation jika tidak ada input arah
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direction *
        speed *
        dt; // Perbarui posisi berdasarkan arah dan kecepatan
  }
}
