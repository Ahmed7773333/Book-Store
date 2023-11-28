import 'package:booh_store_app/core/utils/app_images.dart';
import 'package:booh_store_app/core/utils/app_strings.dart';
import 'package:booh_store_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget settingsTab() {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Icon(
            Icons.settings,
            color: Colors.black,
            size: 33.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          const Text(
            AppStrings.settings,
          ),
        ],
      ),
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150.w,
            height: 150.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.pro),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 379.w,
            height: 430.h,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: AppStyles.titleOfItems,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Ahmed Mohmed Ali',
                    style: AppStyles.titleOfItems.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Email',
                    style: AppStyles.titleOfItems,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'ahmedmohmedyahoo2@gmail.com',
                    style: AppStyles.titleOfItems.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Phone Number',
                    style: AppStyles.titleOfItems,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '0101010110',
                    style: AppStyles.titleOfItems.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Address',
                    style: AppStyles.titleOfItems,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '***********************',
                    style: AppStyles.titleOfItems.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
