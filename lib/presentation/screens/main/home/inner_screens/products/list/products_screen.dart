import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/logger.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:go_router_demo/presentation/screens/main/home/bloc/home_bloc.dart';
import 'package:go_router_demo/presentation/screens/main/home/bloc/home_event.dart';
import 'package:go_router_demo/presentation/screens/main/home/bloc/home_screen_state.dart';
import 'package:go_router_demo/presentation/screens/main/home/inner_screens/products/widgets/product_list_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  HomeBloc homeBlocOf(BuildContext context) =>
      BlocProvider.of<HomeBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeScreenState>(builder: (
      context,
      HomeScreenState homeState,
    ) {
      Logger.log('homeState: $homeState');
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Delimiter.height(16),
          const Text('Products list Screen'),
          const Delimiter.height(16),
          _buildList(context, homeState),
        ],
      );
    });
  }

  Widget _buildList(BuildContext context, HomeScreenState homeState) {
    return Expanded(
      child: ListView.separated(
        itemCount: homeState.productList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final item = homeState.productList[index];
          return ProductListItem(
            entity: item,
            onDeleteSelected: (entity) {
              homeBlocOf(context).add(RemoveItemEvent(entity));
            },
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
