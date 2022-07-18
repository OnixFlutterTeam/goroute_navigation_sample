import 'package:go_router_demo/domain/entities/product_entity.dart';

abstract class ProductFavouriteRepository {
  List<ProductEntity> findAllFavouriteProduct();

  ProductEntity findFavProductById(int id);

  void insertProduct(ProductEntity product);

  void deleteProduct(ProductEntity product);
}
