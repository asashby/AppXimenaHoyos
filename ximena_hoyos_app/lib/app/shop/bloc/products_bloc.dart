
import 'package:data/models/products_payload_model.dart';
import 'package:data/repositories/products_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/main.dart';

enum ProductStatus { initial, error, loading, success }

class ProductState extends Equatable {
  final List<Product>? products;
  final List<Categories>? productCategories;
  final ProductStatus status;
  final dynamic error;

  ProductState(this.status, {this.products, this.productCategories, this.error});

  @override
  List<Object?> get props => [products, status, error];

  factory ProductState.success(List<Product>? products, List<Categories>? productCategories) {
    return ProductState(
      ProductStatus.success, 
      products: products,
      productCategories: productCategories
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
class ProductApplyFilterEvent extends ProductEvent {
  final ProductsFilter filter;
  final int categoryId;
  final int categoryIndex;

  ProductApplyFilterEvent(this.filter, this.categoryId, this.categoryIndex);
}

// Bloc Product

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository repository;
  var filter = ProductsFilter.all;
  var categoryId = 1;
  var page = 1;

  ProductBloc(
      this.repository,
  ) : super(ProductState.initial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    List<Categories>? categories = [
      Categories(
        id: 0,
        name: "TODOS",
        description: "Filtrar por todas las categorías",
        isActive: 1
      )
    ];

    if (event is ProductFetchEvent) {
      try {
        yield ProductState.loading();
        final productsData = await repository.fetchProducts(page);
        final productsCategoriesData = await repository.fetchProductsCategories();

        productsCategoriesData.forEach((element) {
          categories.add(element);
        });

        productsRawData = productsData;
        productsFilteredData = productsData;
        categoriesRawData = categories;
        yield ProductState.success(
          productsData,
          categories
        );
        page++;
      } catch (ex) {
        yield ProductState.error(ex);
      }
    } else if (event is ProductApplyFilterEvent){
      // if (event.filter == filter) {
      //   return; // No se puede volver a repetir
      // }
      yield ProductState.loading();
      List<Product> filteredProducts = [];

      if (event.categoryIndex == 0){
        filteredProducts = productsRawData; 
      }
      else{
        productsRawData.forEach((element) {
          bool hasCategory = false;

          element.categories!.forEach((element) {
            if(element.name!.toLowerCase() == categoriesRawData![event.categoryIndex].name!.toLowerCase()){
              hasCategory = true;
            }
            else{
              hasCategory = false;
            }
          });

          if(hasCategory){
            filteredProducts.add(element);
          }else{
            //do nothing
          }
        });
      }
      
      yield ProductState.success(filteredProducts, categories);
      // try {
      //   filter = event.filter;
      //   categoryId = event.categoryId;

      //   final productsCategoriesData = await repository.fetchProductsCategories();
      //   final productsData = await repository.fetchProducts(page, filter: filter, categoryId: categoryId);

      //   productsCategoriesData.forEach((element) {
      //     categories.add(element);
      //   });

      //   productsRawData = productsData;
        
      //   yield ProductState.success(productsData, categories);
      //   page++;
      // } catch (ex) {
      //   yield ProductState.error(ex);
      // }
    }
  }
}