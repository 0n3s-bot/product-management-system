import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  // Toast(LoginErrorResponse loginErrorResponse);

  static showMessage(
    String message, {
    String? description,
    BuildContext? context,
    Color? txtcolor,
    bgcolor,
    ToastificationType? toastType,
    bool isError = false,
  }) {
    return toastification.show(
        // backgroundColor: AppColors.kGreenColor,
        context: context,
        dragToClose: true,
        description: description != null
            ? Text(
                description,
              )
            : null,
        title: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            // color: AppColors.kMatteBlack,
          ),
        ),
        style: ToastificationStyle.minimal,
        // primaryColor: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(8),
        showProgressBar: false,
        type: isError
            ? ToastificationType.error
            : toastType ?? ToastificationType.success,
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.bottomCenter);

    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_SHORT,
    //     timeInSecForIosWeb: 4,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor:
    //         bgcolor ?? (isError ? AppColors.kRedColor : AppColors.kGreenColor),
    //     textColor: txtcolor ??
    //         (bgcolor == AppColors.kwhiteColor
    //             ? AppColors.kMatteBlack
    //             : AppColors.kwhiteColor),
    //     fontSize: 16);
  }
}
