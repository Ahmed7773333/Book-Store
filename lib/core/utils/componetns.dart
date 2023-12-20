import 'dart:typed_data';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_images.dart';

class Componetns {
  static Widget customTextField({
    required String hint,
    bool? isPassword,
    bool? isShow,
    VoidCallback? onPressed,
    IconData? icon,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 339.w,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ?? false ? (isShow ?? false) : false,
        validator: (value) {
          if (value?.trim().isEmpty ?? false) {
            return 'Field can\'t be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            size: 30.sp,
            color: AppColors.primary,
          ),
          suffixIcon: isPassword ?? false
              ? InkWell(
                  onTap: onPressed,
                  child: Icon(
                    !(isShow ?? false)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.primary,
                    size: 30.sp,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  static Widget openContainers({Widget? closedWidget, Widget? openedWidget}) {
    return OpenContainer(
      closedElevation: 0,
      openElevation: 0,
      transitionDuration: const Duration(milliseconds: 500),
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      closedBuilder: (BuildContext context, void Function() action) {
        return closedWidget!;
      },
      openBuilder:
          (BuildContext context, void Function({Object? returnValue}) action) {
        return openedWidget!;
      },
    );
  }

  static Widget ratingStars(num n) {
    return SizedBox(
      width: 86.w,
      height: 14.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          star(n--),
          star(n--),
          star(n--),
          star(n--),
          star(n--),
        ],
      ),
    );
  }

  static Widget image(String url) {
    return url == ''
        ? Container(
            width: 109.w,
            height: 145.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.logo,
                ),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: 109.w,
            height: 145.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.fill,
              ),
            ),
          );
  }

  static Widget hiveImage(Uint8List url) {
    return url.isEmpty
        ? Container(
            width: 109.w,
            height: 145.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.logo,
                ),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: 109.w,
            height: 145.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(url),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ),
          );
  }
}

Widget star(num n) {
  return n >= 1
      ? Icon(
          Icons.star_outlined,
          color: const Color(0xffFFC41F),
          size: 16.r,
        )
      : n == 0.5
          ? Icon(
              Icons.star_half_outlined,
              color: const Color(0xffFFC41F),
              size: 16.r,
            )
          : Icon(
              Icons.star_border_outlined,
              color: const Color(0xffFFC41F),
              size: 16.r,
            );
}
