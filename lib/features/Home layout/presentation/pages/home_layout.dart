import 'package:booh_store_app/core/api/api_manager.dart';
import 'package:booh_store_app/features/Home%20layout/data/datasources/home_remote_ds_impl.dart';
import 'package:booh_store_app/features/Home%20layout/data/repositories/home_repo_impl.dart';
import 'package:booh_store_app/features/Home%20layout/domain/usecases/get_books.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/pages/category_tab.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/pages/home_tab.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/pages/saved_tab.dart';
import 'package:booh_store_app/features/Home%20layout/presentation/pages/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_layout_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  late PageController _pageController;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeLayoutBloc(
            GetBooksUsecase(HomeRepoImpl(HomeRemoteDSImpl(ApiManager()))))
          ..add(GetBestSellBooks())
          ..add(GetNewestBooks()),
        child: BlocConsumer<HomeLayoutBloc, HomeLayoutState>(
            listener: (context, state) {
          if (state.status == ScreenStatus.searchedBooksError) {
            state.searchedBooks = [];
          }
          if (state.status == ScreenStatus.homeLoading) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
              ),
            );
          }
          if (state.status == ScreenStatus.newestBookssSuccess ||
              state.status == ScreenStatus.bestSellBookssSuccess) {
            Navigator.pop(context);
          }
          if (state.status == ScreenStatus.bestSellBooksError ||
              state.status == ScreenStatus.newestBooksError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(
                    child: Icon(
                  Icons.error,
                  color: Colors.red,
                )),
              ),
            );
          }

          // Add more conditions for other statuses if needed
        }, builder: (context, state) {
          final bloc = HomeLayoutBloc.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: PageView(
              controller: _pageController,
              children: [
                homeTab(state.bestSellBooks ?? [], state.newestBooks ?? [],
                    state.searchedBooks ?? [], searchController, () {
                  HomeLayoutBloc.get(context)
                      .add(SearchForBook(query: searchController.text));
                }, bloc),
                savedTab(bloc.resultBooked),
                categoriesTab(
                    state.bestSellBooks ?? [], state.newestBooks ?? []),
                settingsTab(),
              ],
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _pageController.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.format_list_bulleted),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: '',
                ),
              ],
            ),
          );
        }));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
