import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentImageCarousel extends StatefulWidget {
  final List<String>? images;
  final bool? autoSlide;

  ///[scrollInterval] in milliseconds
  final int? scrollInterval;
  const ContentImageCarousel({
    super.key,
    required this.images,
    this.autoSlide = false,
    this.scrollInterval,
  });

  @override
  State<ContentImageCarousel> createState() => _ContentImageCarouselState();
}

enum IndicatorPosition { inside, outside }

class _ContentImageCarouselState extends State<ContentImageCarousel> {
  final PageController _pageController = PageController();
  Timer? _autoScrollTimer;
  int _currentImage = 0;
  Timer? _animationTimer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        print("Pen stat");
        print(details);
      },
      onTapDown: (details) {
        print("Tap Down");
        print(details.localPosition);
        print(details.globalPosition.direction);
        print(details.globalPosition);
      },
      onTapUp: (details) {
        print("Tap Up");
        print(details.localPosition);
        print(details.globalPosition.direction);
        print(details.globalPosition);
      },
      child: AnimatedContainer(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.shade100,
          ),
        ),
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images?.length ?? 0,
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final imageUrl = widget.images?[index];
                return CachedNetworkImage(
                  imageUrl: imageUrl ?? '',
                  fit: BoxFit.cover,
                );
              },
            ),
            Positioned(
              child: _buildWidgetIndicators(
                scrollDirection: Axis.vertical,
              ),
            ),
            Positioned(
              child: _buildWidgetIndicators(
                scrollDirection: Axis.horizontal,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: _buildWidgetIndicators(
                scrollDirection: Axis.horizontal,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: _buildWidgetIndicators(
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _stopAutoScroll();
    _animationTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.autoSlide == true) {
      _startAutoScroll();
    }
    _pageController.addListener(_pageListener);
  }

  void _animateCurrentImage(int targetPage) {
    if (_animationTimer != null && _animationTimer!.isActive) {
      _animationTimer!.cancel();
    }

    final step = targetPage > _currentImage ? 1 : -1;
    _animationTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _currentImage += step;
        print(_currentImage);
      });
      if (_currentImage == targetPage) {
        timer.cancel();
      }
    });
  }

  Widget _buildWidgetIndicators({
    Axis scrollDirection = Axis.horizontal,
  }) {
    return Container(
      width: scrollDirection == Axis.vertical ? 50 : Get.width,
      height: scrollDirection == Axis.vertical ? Get.height : 50,
      decoration: const BoxDecoration(
        color: Colors.white10,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: scrollDirection,
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        padding: const EdgeInsets.all(5),
        itemCount: widget.images?.length ?? 0,
        itemBuilder: (context, index) {
          final imageUrl = widget.images?[index];
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
              duration: Durations.short1,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    imageUrl!,
                  ),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: _currentImage == index ? Colors.red : Colors.white,
                ),
              ),
              width: 30,
              height: 40,
            ),
          );
        },
      ),
    );
  }

  void _pageListener() {
    final targetPage = _pageController.page?.round() ?? 0;
    if (targetPage != _currentImage) {
      _animateCurrentImage(targetPage);
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(
      Duration(milliseconds: widget.scrollInterval ?? 1000),
      (timer) {
        if (_pageController.hasClients) {
          final nextPage = (_pageController.page ?? 0) + 1;
          _pageController.animateToPage(
            nextPage.toInt() % (widget.images?.length ?? 1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
          );
        }
      },
    );
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }
}
