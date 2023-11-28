import 'package:booh_store_app/config/app_routes.dart';
import 'package:booh_store_app/core/utils/app_images.dart';
import 'package:booh_store_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(AppStrings.back),
        ),
        actions: [
          Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 22.r),
          SizedBox(
            width: 5.w,
          ),
          Text(
            'Shopping Cart',
            style: AppStyles.title,
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: 411.w,
            height: 57.h,
            decoration: const BoxDecoration(color: Color(0xFFC9C9C9)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.shipCar),
                SizedBox(
                  width: 12.w,
                ),
                Text('Please choose the item you want to buy.',
                    style: AppStyles.subStyle),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 411.w,
            height: 65.h,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  top: 16.h,
                  left: 120.w,
                  child: Text('Subtotal:', style: AppStyles.subStyle),
                ),
                Positioned(
                  top: 35.h,
                  left: 120.w,
                  child: Text('EGP 0:', style: AppStyles.subStyle),
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.check);
                    },
                    child: Container(
                      width: 96.w,
                      height: 65.h,
                      decoration: const BoxDecoration(color: Color(0xFFFF0000)),
                      child: Center(
                        child: Text(
                          'Check Out',
                          style:
                              AppStyles.subStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25.h,
                  left: 37.w,
                  child: Icon(Icons.check_box_outline_blank,
                      color: Colors.black, size: 15.r),
                ),
                Positioned(
                    top: 24.h,
                    left: 58.w,
                    child: Text('All', style: AppStyles.subStyle)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
