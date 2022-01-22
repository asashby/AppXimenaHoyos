

import 'package:data/models/product_model.dart';
import 'package:data/repositories/products_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ProductStatus { initial, error, loading, success }

class ProductState extends Equatable {
  final List<Product>? products;
  final ProductStatus status;
  final dynamic error;

  ProductState(this.status, {this.products, this.error});

  @override
  List<Object?> get props => [products, status, error];

  factory ProductState.success(List<Product>? products) {
    return ProductState(
      ProductStatus.success, 
      products: products
    );
  }

  factory ProductState.error(dynamic error) {
    return ProductState(ProductStatus.error, error: error);
  }

  factory ProductState.loading() {
    return ProductState(ProductStatus.loading);
  }

  factory ProductState.initial() {
    return ProductState(ProductStatus.initial);
  }
}

// Event Product

class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductFetchEvent extends ProductEvent {

  ProductFetchEvent();

  @override
  List<Object?> get props => [];
}

// Bloc Product

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository repository;

  ProductBloc(
      this.repository,
  ) : super(ProductState.initial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductFetchEvent) {

      try {
        yield ProductState.loading();
        final productsData = await repository.fetchProducts();
        yield ProductState.success(
          productsData
        );
      } catch (ex) {
        yield ProductState.error(ex);
      }
    }
  }
}