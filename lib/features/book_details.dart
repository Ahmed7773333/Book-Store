import 'dart:typed_data';

import 'package:booh_store_app/core/cache/marked_db.dart';
import 'package:booh_store_app/core/utils/app_strings.dart';
import 'package:booh_store_app/core/utils/app_styles.dart';
import 'package:booh_store_app/core/utils/componetns.dart';
import 'package:booh_store_app/features/Home%20layout/data/models/book_model.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/bloc/home_layout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/cache/hive_helper/helper.dart';
import '../core/utils/app_images.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key, required this.book});

  final Items book;
  @override
  Widget build(BuildContext context) {
    String url = book.volumeInfo?.imageLinks?.thumbnail ?? '';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(AppStrings.back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              url == ''
                  ? Container(
                      width: 155.w,
                      height: 206.h,
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
                      width: 155.w,
                      height: 206.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              SizedBox(height: 25.h),
              Text(
                book.volumeInfo?.title ?? '',
                style: AppStyles.title,
              ),
              Text(
                book.volumeInfo?.authors?.first ?? '',
                style: AppStyles.titleOfItems,
              ),
              SizedBox(height: 16.h),
              Componetns.ratingStars(book.volumeInfo?.averageRating ?? 0),
              SizedBox(height: 9.h),
              Text(
                '${book.saleInfo?.listPrice?.currencyCode ?? 'EGP'} ${book.saleInfo?.listPrice?.amount.toString() ?? '0'}',
                style: AppStyles.titleOfItems.copyWith(color: Colors.red),
              ),
              SizedBox(height: 17.h),
              Text(
                book.volumeInfo?.description ?? '',
                style: AppStyles.titleOfItems
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 17.h),
              FilledButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.cart,
                      style: AppStyles.title.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 24.r),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

class HiveBookDetails extends StatelessWidget {
  const HiveBookDetails({super.key, required this.book, required this.bloc});

  final MarkedDb book;
  final HomeLayoutBloc bloc;
  @override
  Widget build(BuildContext context) {
    Uint8List url = book.thumbnail ?? Uint8List(0);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(AppStrings.back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              url.isEmpty
                  ? Container(
                      width: 155.w,
                      height: 206.h,
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
                      width: 155.w,
                      height: 206.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(url),
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
              SizedBox(height: 25.h),
              Text(
                book.title ?? '',
                style: AppStyles.title,
              ),
              Text(
                book.author ?? '',
                style: AppStyles.titleOfItems,
              ),
              SizedBox(height: 16.h),
              Componetns.ratingStars(book.averageRating ?? 0),
              SizedBox(height: 9.h),
              Text(
                '${book.currencyCode ?? 'EGP'} ${book.amount.toString()}',
                style: AppStyles.titleOfItems.copyWith(color: Colors.red),
              ),
              SizedBox(height: 17.h),
              Text(
                book.description ?? '',
                style: AppStyles.titleOfItems
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 17.h),
              FilledButton(
                onPressed: () async {
                  Uint8List image = Uint8List(0);
                  if (book.thumbnail != Uint8List(0)) {
                    image = book.thumbnail ?? Uint8List(0);
                  }
                  MarkedDbHelper.add(
                    MarkedDb(
                      isBooked: false,
                      title: book.title ?? '',
                      description: book.description ?? '',
                      averageRating: book.averageRating ?? 0,
                      author: book.author ?? '',
                      currencyCode: book.currencyCode ?? 'EGP',
                      amount: book.amount,
                      thumbnail: image,
                    ),
                  );
                  bloc.add(GetCartBooks());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.cart,
                      style: AppStyles.title.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 24.r),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
