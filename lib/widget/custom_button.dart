import 'package:flutter/material.dart';
import 'package:pms/app_theme/app_colors.dart';

ElevatedButton customButton({
  required String title,
  required void Function()? onPressed,
  double? width,
  double? height,
  double? iconSize,
  double? borderRadius,
  IconData? icon,
  TextStyle? buttontxtStyle,
  Color? backgroundColor,
  Color? foregroundColor,
  bool isOutlined = false,
  bool isLoading = false,
  bool isIconRight = false,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      // disabledForegroundColor: isOutlined
      //     ? isLoading
      //         ? foregroundColor
      //         : null
      //     : backgroundColor ?? AppColors.kPrimaryColor,
      backgroundColor:
          isOutlined ? null : backgroundColor ?? AppColors.kPrimaryColor,
      foregroundColor: foregroundColor ?? AppColors.kwhiteColor,
      surfaceTintColor: AppColors.kwhiteColor,
      disabledBackgroundColor: isOutlined
          ? (foregroundColor ?? AppColors.kPrimaryColor).withOpacity(0.2)
          : AppColors.kPrimaryColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? 8,
        ),
      ),
      side: isOutlined
          ? BorderSide(
              color: foregroundColor ?? AppColors.kPrimaryColor,
            )
          : null,
    ),
    onPressed: isLoading ? null : onPressed,
    child: isLoading
        ? SizedBox(
            width: width,
            height: height ?? 52,
            child: Center(
                child: CircularProgressIndicator(
              color: isOutlined
                  ? foregroundColor
                  : (buttontxtStyle?.color) ??
                      (backgroundColor ?? AppColors.kwhiteColor),
            )),
          )
        : SizedBox(
            width: width,
            height: height ?? 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isIconRight)
                  Visibility(
                      visible: icon == null ? false : true,
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            size: iconSize ?? 22,
                            color: isOutlined
                                ? backgroundColor ?? AppColors.kPrimaryColor
                                : Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      )),
                Text(
                  title,
                  style: buttontxtStyle ??
                      TextStyle(
                        color: isOutlined
                            ? backgroundColor ?? AppColors.kPrimaryColor
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                ),
                if (isIconRight)
                  Visibility(
                      visible: icon == null ? false : true,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            icon,
                            size: iconSize ?? 22,
                            color: isOutlined
                                ? backgroundColor ?? AppColors.kPrimaryColor
                                : Colors.white,
                          ),
                        ],
                      )),
              ],
            ),
          ),
  );
}
