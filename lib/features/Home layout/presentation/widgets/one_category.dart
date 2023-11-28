import 'package:booh_store_app/core/utils/app_styles.dart';
import 'package:booh_store_app/core/utils/componetns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../book_details.dart';
import '../../data/models/book_model.dart';

Widget oneCategory(String text, List<Items> books) {
  return SizedBox(
    height: 200.h,
    width: 380.w,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppStyles.title,
          ),
          SizedBox(
            height: 148.h,
            width: 380.w,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Componetns.openContainers(
                  closedWidget: Componetns.image(
                      books[index].volumeInfo?.imageLinks?.thumbnail ?? ''),
                  openedWidget: BookDetails(
                    book: books[index],
                  ),
                );
              },
              itemCount: books.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 33.w,
                );
              },
            ),
          ),
        ]),
  );
}
