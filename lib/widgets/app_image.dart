import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soundroid/widgets/widgets.dart';

/// A helper class for building Image widgets.
///
/// This widget uses [CachedNetworkImage] to show the image, loading placeholder and error widgets.
///
/// ### Rationale
/// - I want the ability to show a skeleton when a network image is loading
/// - I want the network image and skeleton to fade when changing states
/// - I want to abstract away the shimmer code since it is quite lengthy
/// - I want to abstract away the image error code since it is quite lengthy
class AppImage extends StatelessWidget {
  const AppImage({
    Key? key,
    this.borderRadius = BorderRadius.zero,
    required this.builder,
  }) : super(key: key);

  /// The borderRadius of the image
  final BorderRadius borderRadius;

  /// The function that provides [BuildContext] and expects a [Widget]
  final Widget Function(BuildContext) builder;

  /// Load an image from the internet
  ///
  /// If the [url] property is `null`, a shimmer animation will show
  /// If the [url] property is set and the image is loading, a shimmer animation will show
  /// If the [url] property is set and the image is loaded,
  /// the shimmer will fade away and the image will fade in
  /// If the [url] property is set and an error when loading the image, custom error widget will show
  factory AppImage.network(
    String? url, {
    double? size,
    double? width,
    double? height,
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
                        padding: EdgeInsets.all((size ?? width ?? height)! / 4),
                        child: AppIcon(
                          Icons.error_rounded,
                          color: const Color(0xFFBA000D),
                          size: (size ?? width ?? height)! / 2,
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

  /// Load an image from the /assets folder
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
