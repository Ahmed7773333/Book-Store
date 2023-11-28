import 'package:booh_store_app/core/utils/app_strings.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/widgets/one_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/book_model.dart';

Widget categoriesTab(List<Items> books, List<Items> bookss) {
  return Scaffold(
    drawer: const Drawer(),
    appBar: AppBar(
      title: const Text(AppStrings.categories),
    ),
    body: Padding(
      padding: EdgeInsets.only(left: 24.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            oneCategory('Fantasy', books),
            SizedBox(
              height: 20.h,
            ),
            oneCategory('Comic', books.reversed.toList()),
            SizedBox(
              height: 20.h,
            ),
            oneCategory('Science', bookss),
            SizedBox(
              height: 20.h,
            ),
            oneCategory('General', bookss.reversed.toList()),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    ),
  );
}
