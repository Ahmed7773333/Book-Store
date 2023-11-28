import 'package:booh_store_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget savedTab() {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Icon(
            Icons.bookmark_border_outlined,
            color: Colors.black,
            size: 33.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          const Text(
            AppStrings.bookMark,
          ),
        ],
      ),
    ),
  );
}
