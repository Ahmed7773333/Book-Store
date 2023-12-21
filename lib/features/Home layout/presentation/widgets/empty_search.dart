import 'dart:typed_data';

import 'package:booh_store_app/core/utils/componetns.dart';
import 'package:booh_store_app/features/Home%20layout/data/models/book_model.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/bloc/home_layout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/cache/hive_helper/helper.dart';
import '../../../../core/cache/marked_db.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../book_details.dart';
import '../pages/home_tab.dart';

Widget emptySearch(
  List<Items> bestSellBooks,
  List<Items> newestBooks,
  HomeLayoutBloc bloc,
) {
  return Stack(
    children: [
      Positioned(
        top: 155.h,
        left: 33.w,
        child: Text(
          AppStrings.bestSell,
          style: AppStyles.title,
        ),
      ),
      Positioned(
        top: 201.h,
        left: 33.w,
        child: SizedBox(
          height: 148.h,
          width: 380.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Componetns.openContainers(
                closedWidget: Componetns.image(
                    bestSellBooks[index].volumeInfo?.imageLinks?.thumbnail ??
                        ''),
                openedWidget: BookDetails(
                  book: bestSellBooks[index],
                ),
              );
            },
            itemCount: bestSellBooks.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 33.w,
              );
            },
          ),
        ),
      ),
      Positioned(
        top: 370.h,
        child: Divider(
          color: Colors.black,
          thickness: 1.h,
        ),
      ),
      Positioned(
        top: 350.h,
        left: 33.w,
        child: Text(
          AppStrings.newRelease,
          style: AppStyles.title,
        ),
      ),
      Positioned(
        top: 380.h,
        left: 28.w,
        child: SizedBox(
          height: 328.h,
          width: 300.w,
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
                        newestBooks[index].volumeInfo?.title ?? '',
                        style: AppStyles.titleOfItems,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Positioned(
                        top: 14.h,
                        child: Text(
                          newestBooks[index].volumeInfo?.authors?.first ?? '',
                          style: AppStyles.subStyle,
                        ),
                      ),
                      Positioned(
                        top: 28.h,
                        child: Text(
                          '${newestBooks[index].saleInfo?.listPrice?.currencyCode ?? 'EGP'} ${newestBooks[index].saleInfo?.listPrice?.amount.toString() ?? '0'}',
                          style: AppStyles.titleOfItems
                              .copyWith(color: Colors.red),
                        ),
                      ),
                      Positioned(
                        bottom: 48.h,
                        child: Componetns.ratingStars(
                            newestBooks[index].volumeInfo?.averageRating ?? 0),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          color: Colors.black,
                          onPressed: () async {
                            Uint8List image = Uint8List(0);
                            if ((newestBooks[index]
                                        .volumeInfo
                                        ?.imageLinks
                                        ?.thumbnail ??
                                    '') !=
                                '') {
                              image = await loadImage(newestBooks[index]
                                      .volumeInfo
                                      ?.imageLinks
                                      ?.thumbnail ??
                                  '');
                            }
                            MarkedDbHelper.add(
                              MarkedDb(
                                isBooked: true,
                                title:
                                    newestBooks[index].volumeInfo?.title ?? '',
                                description: newestBooks[index]
                                        .volumeInfo
                                        ?.description ??
                                    '',
                                averageRating: newestBooks[index]
                                        .volumeInfo
                                        ?.averageRating ??
                                    0,
                                author: newestBooks[index]
                                        .volumeInfo
                                        ?.authors
                                        ?.first ??
                                    '',
                                currencyCode: newestBooks[index]
                                        .saleInfo
                                        ?.listPrice
                                        ?.currencyCode ??
                                    'EGP',
                                amount: newestBooks[index]
                                    .saleInfo
                                    ?.listPrice
                                    ?.amount,
                                thumbnail: image,
                              ),
                            );
                            bloc.add(GetBookedBooks());
                          },
                          icon: Icon(
                            Icons.bookmark_border_outlined,
                            color: Colors.black,
                            size: 35.r,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Componetns.image(newestBooks[index]
                                .volumeInfo
                                ?.imageLinks
                                ?.thumbnail ??
                            ''),
                      ),
                    ],
                  ),
                ),
                openedWidget: BookDetails(
                  book: newestBooks[index],
                ),
              );
            },
            itemCount: newestBooks.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 38.h,
              );
            },
          ),
        ),
      ),
    ],
  );
}
