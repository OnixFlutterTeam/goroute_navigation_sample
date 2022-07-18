import 'package:go_router_demo/domain/entities/product_entity.dart';
import 'package:go_router_demo/domain/repository/product/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final List<ProductEntity> _productList = [];

  @override
  void insertProduct(ProductEntity product) {
    _productList.add(product);
  }

  @override
  List<ProductEntity> findAllProduct() {
    return _productList;
  }

  @override
  ProductEntity findProductById(int id) {
    return _productList.firstWhere((product) => product.id == id);
  }

  @override
  void deleteProduct(ProductEntity product) {
    _productList.remove(product);
  }

  @override
  void insertProductList(List<ProductEntity> list) {
    _productList.addAll(list);
  }
}
