import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/dependency/service_locator.dart';
import 'package:go_router_demo/presentation/widgets/misk.dart';
import 'package:go_router_demo/utils/ui_utils.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.productId,
    this.showRemoveBtn = true,
  }) : super(key: key);

  final int productId;
  final bool showRemoveBtn;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final entity = productSource().findProductById(widget.productId);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Product item Screen'),
            const Delimiter.height(16),
            DefaultButton(
              title: 'Navigate back',
              onTap: () {
                context.pop();
              },
            ),
            Container(
              width: UiUtil.screenWidth(context),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(entity.description),
                  ),
                  const Delimiter.width(38),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: entity.isFavorite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_outline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
