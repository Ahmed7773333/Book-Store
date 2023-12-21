import 'package:dio/dio.dart';

import 'package:booh_store_app/core/cache/hive_helper/helper.dart';
import 'package:booh_store_app/core/cache/marked_db.dart';
import 'package:booh_store_app/core/utils/app_images.dart';
import 'package:booh_store_app/core/utils/app_strings.dart';
import 'package:booh_store_app/core/utils/app_styles.dart';
import 'package:booh_store_app/core/utils/componetns.dart';
import 'package:booh_store_app/features/Cart/presentation/pages/cart_page.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/bloc/home_layout_bloc.dart';
import 'package:booh_store_app/features/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/book_model.dart';
import '../widgets/empty_search.dart';

// ignore: must_be_immutable
class HomeTab extends StatelessWidget {
  HomeTab(this.bestSellBooks, this.newestBooks, this.results,
      this.searchController, this.onTab, this.bloc,
      {super.key});
  List<Items> bestSellBooks;
  List<Items> newestBooks;
  List<Items> results;
  TextEditingController searchController;
  VoidCallback onTab;
  HomeLayoutBloc bloc;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 23.h,
            left: 18.w,
            child: Container(
              width: 41.w,
              height: 41.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.pro),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 35.h,
            left: 83.w,
            child: Text(
              AppStrings.welcome,
              style: AppStyles.titleOfItems,
            ),
          ),
          Positioned(
            top: 29.h,
            right: 31.w,
            child: Componetns.openContainers(
                closedWidget: Icon(Icons.shopping_cart_outlined,
                    color: Colors.black, size: 29.r),
                openedWidget: CartPage(bloc.resultCart, bloc)),
          ),
          Positioned(
            top: 98.h,
            right: 69.w,
            child: Container(
              width: 274.w,
              height: 27.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFDFDFDF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.50),
                ),
              ),
              child: TextField(
                style: AppStyles.titleOfItems.copyWith(color: Colors.black),
                controller: searchController,
                decoration: InputDecoration(
                    suffixIcon:
                        Icon(Icons.search, color: Colors.black, size: 19.r),
                    enabled: true,
                    hintText: AppStrings.search),
                onChanged: (q) {
                  onTab();
                },
                onSubmitted: (q) {
                  onTab();
                },
              ),
            ),
          ),
          results.isNotEmpty
              ? Positioned(
                  top: 155.h,
                  left: 28.w,
                  child: SizedBox(
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
                                  results[index].volumeInfo?.title ?? '',
                                  style: AppStyles.titleOfItems,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Positioned(
                                  top: 14.h,
                                  child: Text(
                                    results[index].volumeInfo?.authors?.first ??
                                        '',
                                    style: AppStyles.subStyle,
                                  ),
                                ),
                                Positioned(
                                  top: 28.h,
                                  child: Text(
                                    '${results[index].saleInfo?.listPrice?.currencyCode ?? 'EGP'} ${results[index].saleInfo?.listPrice?.amount.toString() ?? '0'}',
                                    style: AppStyles.titleOfItems
                                        .copyWith(color: Colors.red),
                                  ),
                                ),
                                Positioned(
                                  bottom: 48.h,
                                  child: Componetns.ratingStars(results[index]
                                          .volumeInfo
                                          ?.averageRating ??
                                      0),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Componetns.image(results[index]
                                          .volumeInfo
                                          ?.imageLinks
                                          ?.thumbnail ??
                                      ''),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    color: Colors.black,
                                    onPressed: () async {
                                      Uint8List image = Uint8List(0);
                                      if ((results[index]
                                                  .volumeInfo
                                                  ?.imageLinks
                                                  ?.thumbnail ??
                                              '') !=
                                          '') {
                                        image = await loadImage(results[index]
                                                .volumeInfo
                                                ?.imageLinks
                                                ?.thumbnail ??
                                            '');
                                      }
                                      MarkedDbHelper.add(
                                        MarkedDb(
                                          isBooked: true,
                                          title: results[index]
                                                  .volumeInfo
                                                  ?.title ??
                                              '',
                                          description: results[index]
                                                  .volumeInfo
                                                  ?.description ??
                                              '',
                                          averageRating: results[index]
                                                  .volumeInfo
                                                  ?.averageRating ??
                                              0,
                                          author: results[index]
                                                  .volumeInfo
                                                  ?.authors
                                                  ?.first ??
                                              '',
                                          currencyCode: results[index]
                                                  .saleInfo
                                                  ?.listPrice
                                                  ?.currencyCode ??
                                              'EGP',
                                          amount: results[index]
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
                              ],
                            ),
                          ),
                          openedWidget: BookDetails(
                            book: results[index],
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
                )
              : emptySearch(bestSellBooks, newestBooks, bloc)
        ],
      ),
    );
  }
}

Future<Uint8List> loadImage(String imageUrl) async {
  try {
    Dio dio = Dio();
    Response<List<int>> response = await dio.get<List<int>>(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data!);
    } else {
      throw Exception('Failed to load image: $imageUrl');
    }
  } catch (error) {
    throw Exception('Error loading image: $error');
  }
}
