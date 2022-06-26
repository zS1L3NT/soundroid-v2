import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soundroid/widgets/widgets.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    Key? key,
    this.borderRadius = BorderRadius.zero,
    required this.builder,
  }) : super(key: key);

  final BorderRadius borderRadius;

  final Widget Function(BuildContext) builder;

  factory AppImage.network(
    String? url, {
    double? size,
    double? width,
    double? height,
    double errorIconPadding = 0,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return AppImage(
      borderRadius: borderRadius,
      builder: (context) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: url != null
              ? CachedNetworkImage(
                  key: ValueKey(url),
                  imageUrl: url,
                  placeholder: (context, url) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: size ?? width,
                        height: size ?? height,
                        color: Colors.black,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      color: const Color.fromARGB(255, 255, 220, 220),
                      child: Padding(
                        padding: EdgeInsets.all(errorIconPadding),
                        child: const AppIcon(
                          Icons.error_rounded,
                          color: Color(0xFFBA000D),
                        ),
                      ),
                    );
                  },
                  fadeInCurve: Curves.decelerate,
                  fadeInDuration: const Duration(milliseconds: 300),
                  fit: BoxFit.cover,
                  width: size ?? width,
                  height: size ?? height,
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: size ?? width,
                    height: size ?? height,
                    color: Colors.black,
                  ),
                ),
        );
      },
    );
  }

  factory AppImage.asset(
    String asset, {
    double? size,
    double? width,
    double? height,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return AppImage(
      borderRadius: borderRadius,
      builder: (context) {
        return Image.asset(
          asset,
          width: size ?? width,
          height: size ?? height,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: builder(context),
    );
  }
}
