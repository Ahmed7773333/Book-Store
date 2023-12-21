import 'dart:typed_data';

import 'package:booh_store_app/config/app_routes.dart';
import 'package:booh_store_app/core/cache/marked_db.dart';
import 'package:booh_store_app/core/utils/app_images.dart';
import 'package:booh_store_app/core/utils/app_styles.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/bloc/home_layout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/componetns.dart';
import '../../../book_details.dart';

class CartPage extends StatelessWidget {
  const CartPage(this.results, this.bloc, {super.key});
  final List<MarkedDb> results;
  final HomeLayoutBloc bloc;
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
          SizedBox(
            height: 582.h,
            width: 380.w,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Componetns.openContainers(
                  closedWidget: SizedBox(
                    height: 145.h,
                    width: 360.w,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Text(
                          results[index].title ?? '',
                          style: AppStyles.titleOfItems,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Positioned(
                          top: 14.h,
                          child: Text(
                            results[index].author ?? '',
                            style: AppStyles.subStyle,
                          ),
                        ),
                        Positioned(
                          top: 28.h,
                          child: Text(
                            '${results[index].currencyCode ?? 'EGP'} ${results[index].amount.toString()}',
                            style: AppStyles.titleOfItems
                                .copyWith(color: Colors.red),
                          ),
                        ),
                        Positioned(
                          bottom: 48.h,
                          child: Componetns.ratingStars(
                              results[index].averageRating ?? 0),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Componetns.hiveImage(
                              results[index].thumbnail ?? Uint8List(0)),
                        ),
                      ],
                    ),
                  ),
                  openedWidget: HiveBookDetails(
                    book: results[index],
                    bloc: bloc,
                  ),
                );
              },
              itemCount: results.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 33.h,
                );
              },
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
