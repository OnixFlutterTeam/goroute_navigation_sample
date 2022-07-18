import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/logger.dart';
import 'package:go_router_demo/dependency/service_locator.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'bloc/home_bloc.dart';
import 'inner_screens/favourites/favourites_screen.dart';
import 'inner_screens/info/info_screen.dart';
import 'inner_screens/products/list/products_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required String tab,
  })  : index = indexFrom(tab),
        super(key: key);

  final int index;

  static int indexFrom(String tab) {
    Logger.log('indexFrom: $tab');
    switch (tab) {
      case 'list':
        return 0;
      case 'fav':
        return 1;
      case 'info':
        return 2;
      default:
        return 0;
    }
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<HomeBloc>(),
      child: _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [ProductsScreen(), FavouritesScreen(), InfoScreen()],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(
            () {
              _selectedIndex = index;
              switch (index) {
                case 0:
                  context.go(AppRouter.pathProductList);
                  break;
                case 1:
                  context.go(AppRouter.pathFavourite);
                  break;
                case 2:
                  context.go(AppRouter.pathInfo);
                  break;
              }
            },
          );
        },
        items: [
          SalomonBottomBarItem(
            selectedColor: Colors.deepPurpleAccent[200],
            icon: const Icon(
              Icons.list_outlined,
              size: 30,
            ),
            title: const Text('Products'),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.deepPurpleAccent[200],
            icon: const Icon(
              Icons.favorite_outline,
              size: 30,
            ),
            title: const Text('Favourites'),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.deepPurpleAccent[200],
            icon: const Icon(
              Icons.info_outline,
              size: 30,
            ),
            title: const Text('Info'),
          ),
        ],
      ),
    );
  }
}
