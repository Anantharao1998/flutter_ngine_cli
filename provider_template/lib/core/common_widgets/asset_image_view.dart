import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetImageView extends StatelessWidget {
  const AssetImageView(
      {required this.fileName,
      this.height,
      this.width,
      this.color,
      this.scale,
      Key? key})
      : super(key: key);

  final String fileName;
  final double? height;
  final double? width;
  final Color? color;
  final double? scale;

  @override
  Widget build(BuildContext context) {
    return _getView();
  }

  Widget _getView() {
    final String mimType = fileName.split('.').last;

    if (mimType.isEmpty) {
      return Icon(
        Icons.image_not_supported_outlined,
        size: width,
        color: color,
      );
    }

    switch (mimType) {
      case 'svg':
        return SvgPicture.asset(
          fileName,
          height: height,
          width: width,
          colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
        );
      case 'png':
      case 'jpg':
      case 'jpeg':
        return Image.asset(
          fileName,
          height: height,
          width: width,
          color: color,
          scale: scale,
        );
      default:
        return Icon(
          Icons.image_not_supported_outlined,
          size: width,
          color: color,
        );
    }
  }
}
