import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playground/app/models/user.model.dart';

class AvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final Gender? gender;
  const AvatarWidget({
    super.key,
    required this.imageUrl,
    this.radius = 20,
    this.gender = Gender.female,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onLongPress: () {},
        child: CircleAvatar(
          radius: radius,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Image.asset(
              'assets/images/${gender == Gender.male ? 'boy.png' : 'girl.png'}',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/${gender == Gender.male ? 'boy.png' : 'girl.png'}',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
