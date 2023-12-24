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
  List<Items> bestBooks,
  List<Items> newBooks,
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
          child: FutureBuilder(
              // Simulate a delay of 3 seconds before building the first ListView
              future: Future.delayed(const Duration(seconds: 2)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else {
                  return SizedBox(
                    height: 148.h,
                    width: 380.w,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return bestBooks.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.blue))
                            : Componetns.openContainers(
                                closedWidget: Componetns.image(bestBooks[index]
                                        .volumeInfo
                                        ?.imageLinks
                                        ?.thumbnail ??
                                    ''),
                                openedWidget: BookDetails(
                                  book: bestBooks[index],
                                ),
                              );
                      },
                      itemCount: bestBooks.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 33.w,
                        );
                      },
                    ),
                  );
                }
              })),
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
          child: FutureBuilder(
              // Simulate a delay of 3 seconds before building the first ListView
              future: Future.delayed(const Duration(seconds: 4)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else {
                  return SizedBox(
                    height: 328.h,
                    width: 300.w,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return newBooks.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.blue))
                            : Componetns.openContainers(
                                closedWidget: SizedBox(
                                  height: 145.h,
                                  width: 360.w,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Text(
                                        newBooks[index].volumeInfo?.title ?? '',
                                        style: AppStyles.titleOfItems,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Positioned(
                                        top: 14.h,
                                        child: Text(
                                          newBooks[index]
                                                  .volumeInfo
                                                  ?.authors
                                                  ?.first ??
                                              '',
                                          style: AppStyles.subStyle,
                                        ),
                                      ),
                                      Positioned(
                                        top: 28.h,
                                        child: Text(
                                          '${newBooks[index].saleInfo?.listPrice?.currencyCode ?? 'EGP'} ${newBooks[index].saleInfo?.listPrice?.amount.toString() ?? '0'}',
                                          style: AppStyles.titleOfItems
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 48.h,
                                        child: Componetns.ratingStars(
                                            newBooks[index]
                                                    .volumeInfo
                                                    ?.averageRating ??
                                                0),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: IconButton(
                                          color: Colors.black,
                                          onPressed: () async {
                                            Uint8List image = Uint8List(0);
                                            if ((newBooks[index]
                                                        .volumeInfo
                                                        ?.imageLinks
                                                        ?.thumbnail ??
                                                    '') !=
                                                '') {
                                              image = await loadImage(
                                                  newBooks[index]
                                                          .volumeInfo
                                                          ?.imageLinks
                                                          ?.thumbnail ??
                                                      '');
                                            }
                                            MarkedDbHelper.add(
                                              MarkedDb(
                                                isBooked: true,
                                                title: newBooks[index]
                                                        .volumeInfo
                                                        ?.title ??
                                                    '',
                                                description: newBooks[index]
                                                        .volumeInfo
                                                        ?.description ??
                                                    '',
                                                averageRating: newBooks[index]
                                                        .volumeInfo
                                                        ?.averageRating ??
                                                    0,
                                                author: newBooks[index]
                                                        .volumeInfo
                                                        ?.authors
                                                        ?.first ??
                                                    '',
                                                currencyCode: newBooks[index]
                                                        .saleInfo
                                                        ?.listPrice
                                                        ?.currencyCode ??
                                                    'EGP',
                                                amount: newBooks[index]
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
                                        child: Componetns.image(newBooks[index]
                                                .volumeInfo
                                                ?.imageLinks
                                                ?.thumbnail ??
                                            ''),
                                      ),
                                    ],
                                  ),
                                ),
                                openedWidget: BookDetails(
                                  book: newBooks[index],
                                ),
                              );
                      },
                      itemCount: newBooks.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 38.h,
                        );
                      },
                    ),
                  );
                }
              })),
    ],
  );
}
