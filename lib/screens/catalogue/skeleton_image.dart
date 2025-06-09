import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';

class SkeletonImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  State<SkeletonImage> createState() => _SkeletonImageState();
}

class _SkeletonImageState extends State<SkeletonImage> {
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: Skeletonizer(
        enabled: !_isLoaded,
        child: Image.network(
          widget.imageUrl,
          width: widget.width,
          height: widget.height,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (frame != null && !_isLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() => _isLoaded = true);
              });
            }
            return child;
          },
          errorBuilder: (context, error, stackTrace) {
            if (!_isLoaded) {
              // Pastikan skeleton hilang saat error
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() => _isLoaded = true);
              });
            }
            return Container(
              color: Colors.grey.shade200,
              child: Image.asset(
                'assets/images/reuse-mart.png',
                height: widget.height,
                width: widget.width,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
