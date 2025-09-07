import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

/// url: load image from network
/// file: load image from File
/// asset: load image from asset (svg, png, jpg, ...)
/// circle: circle image
enum AppImageType { url, file, asset, circle }

class AppImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? url;
  final File? file;
  final String? path;
  final BoxFit? boxFit;
  final Widget? errorBuilder;
  final Widget? loadingBuilder;
  final double? borderRadius;
  final AppImageType type;

  const AppImage._({
    required this.type,
    this.width,
    this.height,
    this.borderRadius,
    this.boxFit,
    this.url,
    this.file,
    this.path,
    this.errorBuilder,
    this.loadingBuilder,
  });

  factory AppImage.circle({
    required double size,
    String? url,
    String? path,
    File? file,
    BoxFit? boxFit,
    Widget? errorBuilder,
    Widget? loadingBuilder,
  }) {
    // Đảm bảo chỉ có đúng 1 trong 3 được truyền
    final sources = [url, path, file].where((e) => e != null).length;
    assert(
      sources == 1,
      'AppImage.circle requires exactly one of url, path, or file',
    );

    return AppImage._(
      type: AppImageType.circle,
      width: size,
      height: size,
      url: url,
      path: path,
      file: file,
      boxFit: boxFit,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
    );
  }

  factory AppImage.file({
    required File file,
    double? width,
    double? height,
    BoxFit? boxFit,
    Widget? errorBuilder,
    Widget? loadingBuilder,
    double? borderRadius,
  }) => AppImage._(
    type: AppImageType.file,
    file: file,
    width: width,
    height: height,
    boxFit: boxFit,
    errorBuilder: errorBuilder,
    loadingBuilder: loadingBuilder,
    borderRadius: borderRadius,
  );

  factory AppImage.asset({
    required String path,
    double? width,
    double? height,
    BoxFit? boxFit,
    Widget? errorBuilder,
    Widget? loadingBuilder,
    double? borderRadius,
  }) => AppImage._(
    type: AppImageType.asset,
    path: path,
    width: width,
    height: height,
    boxFit: boxFit,
    errorBuilder: errorBuilder,
    loadingBuilder: loadingBuilder,
    borderRadius: borderRadius,
  );

  factory AppImage.url({
    required String url,
    double? width,
    double? height,
    BoxFit? boxFit,
    Widget? errorBuilder,
    Widget? loadingBuilder,
    double? borderRadius,
  }) => AppImage._(
    type: AppImageType.url,
    url: url,
    width: width,
    height: height,
    boxFit: boxFit,
    errorBuilder: errorBuilder,
    loadingBuilder: loadingBuilder,
    borderRadius: borderRadius,
  );

  @override
  Widget build(BuildContext context) {
    Widget image;
    switch (type) {
      case AppImageType.asset:
        image = _assetImage();
      case AppImageType.url:
        image = _networkImage();
      case AppImageType.file:
        image = _fileImage();
      case AppImageType.circle:
        image = _circleImage();
        break;
    }

    if (type == AppImageType.circle) {
      return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(child: image),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: image,
    );
  }

  Widget _circleImage() {
    if (url != null) {
      return _networkImage();
    }
    if (file != null) {
      return _fileImage();
    }
    if (path != null) {
      return _assetImage();
    }
    return errorBuilder ?? const SizedBox();
  }

  Widget _networkImage() {
    final imageUrl = url?.trim() ?? '';
    if (imageUrl.isEmpty) {
      return errorBuilder ?? const SizedBox();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      key: key,
      width: width,
      height: height,
      fit: boxFit,
      placeholder: (context, url) {
        return loadingBuilder ?? _shimmerWidget();
      },
      errorWidget: (_, _, _) => errorBuilder ?? const SizedBox(),
    );
  }

  Widget _fileImage() {
    return Image.file(
      file!,
      key: key,
      width: width,
      height: height,
      fit: boxFit,
      errorBuilder: (_, _, _) => errorBuilder ?? const SizedBox(),
      frameBuilder: (_, _, _, _) {
        return loadingBuilder ?? _shimmerWidget();
      },
    );
  }

  Widget _assetImage() {
    if (path!.contains('.svg')) {
      return SvgPicture.asset(
        path!,
        key: key,
        width: width,
        height: height,
        fit: boxFit ?? BoxFit.contain,
        errorBuilder: (_, _, _) => errorBuilder ?? const SizedBox(),
        placeholderBuilder: (context) => loadingBuilder ?? _shimmerWidget(),
      );
    }
    return Image.asset(
      path!,
      key: key,
      width: width,
      height: height,
      fit: boxFit,
      errorBuilder: (_, _, _) => errorBuilder ?? const SizedBox(),
      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        if (frame == null) {
          /// Hiển thị shimmer khi chưa có frame
          return loadingBuilder ?? _shimmerWidget();
        } else {
          /// Khi có frame rồi thì fade-in ảnh
          return AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            child: child,
          );
        }
      },
    );
  }

  Widget _shimmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? 0), color: Colors.white),
      ),
    );
  }
}
