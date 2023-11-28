import 'package:booh_store_app/core/utils/app_images.dart';
import 'package:booh_store_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

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
          Text(
            'Check Out',
            style: AppStyles.title,
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 411.w,
            height: 65.h,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  top: 16.h,
                  left: 120.w,
                  child: Text('Total Payment:', style: AppStyles.subStyle),
                ),
                Positioned(
                  top: 35.h,
                  left: 120.w,
                  child: Text('EGP 0:', style: AppStyles.subStyle),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 96.w,
                    height: 65.h,
                    decoration: const BoxDecoration(color: Color(0xFFFF0000)),
                    child: Center(
                      child: Text(
                        'Buy',
                        style: AppStyles.subStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Delivery  Address', style: AppStyles.titleOfItems),
                SizedBox(
                  height: 10.h,
                ),
                Text('***********************', style: AppStyles.smallStyle),
                SizedBox(
                  height: 20.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text('Item', style: AppStyles.titleOfItems),
                SizedBox(
                  height: 151.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 13.h,
                ),
                Text('Order Total( 0 Item):', style: AppStyles.titleOfItems),
                SizedBox(
                  height: 15.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text('Payment Option:', style: AppStyles.titleOfItems),
                SizedBox(
                  height: 22.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.masterCard,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      AppImages.visa,
                    ),
                  ],
                ),
                SizedBox(
                  height: 38.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 37.h,
                ),
                Text('Item Subtotal:', style: AppStyles.titleOfItems),
                SizedBox(
                  height: 6.h,
                ),
                Text('Shipping Subtotal:', style: AppStyles.titleOfItems),
                SizedBox(
                  height: 15.h,
                ),
                Text('Total Payment:', style: AppStyles.title),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
