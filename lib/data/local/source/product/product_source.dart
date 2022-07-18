import 'package:go_router_demo/domain/entities/product_entity.dart';

abstract class ProductSource {
  List<ProductEntity> findAllFavouriteProduct();

  List<ProductEntity> findAllProduct();

  ProductEntity findProductById(int id);

  ProductEntity findFavProductById(int id);

  void insertFavProduct(ProductEntity product);

  void deleteFavProduct(ProductEntity product);

  void deleteProduct(ProductEntity product);

  void insertProduct(ProductEntity product);

  void insertProductList(List<ProductEntity> list);
}
