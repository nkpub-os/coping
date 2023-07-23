import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    super.key,
    required this.assetPath,
    this.size = 24,
    this.color,
  });

  final String assetPath;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconColor = ColorFilter.mode(
      color ?? Theme.of(context).iconTheme.color!,
      BlendMode.srcIn,
    );

    return SvgPicture.asset(
      assetPath,
      colorFilter: iconColor,
      width: size,
      height: size,
    );
  }
}
