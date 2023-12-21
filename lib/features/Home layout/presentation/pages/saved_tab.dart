import 'dart:typed_data';

import 'package:booh_store_app/core/cache/marked_db.dart';
import 'package:booh_store_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/componetns.dart';
import '../../../book_details.dart';

Widget savedTab(
  List<MarkedDb> results,
  bloc,
) {
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
    body: SizedBox(
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
                      style: AppStyles.titleOfItems.copyWith(color: Colors.red),
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
  );
}
