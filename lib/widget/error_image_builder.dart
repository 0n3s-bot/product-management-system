import 'package:flutter/cupertino.dart';
import 'package:pms/app_theme/app_colors.dart';

Widget buildErrorImage({
  double? width,
  double? height,
  IconData? icon,
  double? size,
}) {
  return Container(
    decoration: BoxDecoration(color: AppColors.kLightGreyColor),
    height: height,
    width: width,
    alignment: Alignment.center,
    child: Icon(
      icon ?? CupertinoIcons.photo,
      size: size,
      color: AppColors.kGreyColor,
    ),
  );
}
