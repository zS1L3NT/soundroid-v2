import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soundroid/widgets/widgets.dart';

class AppImage extends StatefulWidget {
  const AppImage({
    Key? key,
    this.borderRadius = BorderRadius.zero,
    required this.child,
  }) : super(key: key);

  final BorderRadius borderRadius;

  final Widget Function(BuildContext) child;

  factory AppImage.networkPlaylistFade(String url) {
    return AppImage(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ),
      child: (context) {
        return ShaderMask(
          shaderCallback: (rectangle) => const LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.5, 1.0],
          ).createShader(rectangle),
          blendMode: BlendMode.dstIn,
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.black,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                color: const Color.fromARGB(255, 255, 220, 220),
                child: const AppIcon(
                  Icons.error_rounded,
                  color: Color(0xFFBA000D),
                ),
              );
            },
            fadeInCurve: Curves.decelerate,
            fadeInDuration: const Duration(milliseconds: 300),
            fit: BoxFit.cover,
            width: 60,
            height: 60,
          ),
        );
      },
    );
  }

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
      child: (context) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: url != null
              ? CachedNetworkImage(
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
      child: (context) {
        return Image.asset(
          asset,
          width: size ?? width,
          height: size ?? height,
        );
      },
    );
  }

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: widget.child(context),
    );
  }
}
