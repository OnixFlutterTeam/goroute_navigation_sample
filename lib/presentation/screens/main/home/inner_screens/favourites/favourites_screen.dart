import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/widget/base/base_block_state.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:go_router_demo/presentation/screens/main/home/bloc/home_bloc.dart';
import 'package:go_router_demo/presentation/screens/main/home/bloc/home_event.dart';
import 'package:go_router_demo/presentation/screens/main/home/bloc/home_screen_state.dart';
import 'package:go_router_demo/presentation/screens/main/home/inner_screens/products/widgets/product_list_item.dart';

import 'bloc/fav_bloc.dart';
import 'bloc/fav_screen_state.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState
    extends BaseState<FavouriteScreenState, FavouriteBloc, FavouritesScreen> {
  HomeBloc homeBlocOf(BuildContext context) =>
      BlocProvider.of<HomeBloc>(context);

  @override
  Widget buildWidget(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeScreenState>(builder: (
      context,
      HomeScreenState homeState,
    ) {
      return stateObserver(
        context,
        (FavouriteScreenState favState) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Delimiter.height(16),
              const Text('Favourites Screen'),
              const Delimiter.height(16),
              //TODO need ability navigate to tabs.
              // DefaultButton(
              //   title: 'Navigate to products list screen',
              //   onTap: () {
              //     context.go(AppRouter.pathProductList);
              //   },
              // ),
              _buildList(context, homeState),
            ],
          );
        },
        listenDelegate: (context, state) async {},
      );
    });
  }

  Widget _buildList(BuildContext context, HomeScreenState homeState) {
    return Expanded(
      child: ListView.separated(
        itemCount: homeState.favProductList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final item = homeState.favProductList[index];
          return ProductListItem(
            entity: item,
            showRemoveBtn: false,
            onDeleteSelected: (entity) {},
            onSelected: (entity) {
              context.push(
                AppRouter.pathProduct,
                extra: entity.id,
              );
            },
            onSetFavourite: (entity) {
              homeBlocOf(context).add(!entity.isFavorite
                  ? RemoveFavouriteEvent(entity)
                  : AddFavouriteEvent(entity));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE0E0E0),
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
