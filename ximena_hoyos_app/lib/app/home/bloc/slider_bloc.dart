
import 'package:data/models/products_payload_model.dart';
import 'package:data/models/slider_item_model.dart';
import 'package:data/repositories/products_repository.dart';
import 'package:data/repositories/slider_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/main.dart';

enum SliderStatus { initial, error, loading, success }

class SliderState extends Equatable {
  final List<SliderItem>? sliderItems;
  final SliderStatus status;
  final dynamic error;

  SliderState(this.status, {this.sliderItems, this.error});

  @override
  List<Object?> get props => [sliderItems, status, error];

  factory SliderState.success(List<SliderItem>? sliderItems) {
    return SliderState(
      SliderStatus.success, 
      sliderItems: sliderItems,
    );
  }

  factory SliderState.error(dynamic error) {
    return SliderState(SliderStatus.error, error: error);
  }

  factory SliderState.loading() {
    return SliderState(SliderStatus.loading);
  }

  factory SliderState.initial() {
    return SliderState(SliderStatus.initial);
  }
}

// Event Slider

class SliderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SliderFetchEvent extends SliderEvent {

  SliderFetchEvent();

  @override
  List<Object?> get props => [];
}

// Bloc Slider

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final SliderRepository repository;

  SliderBloc(
      this.repository,
  ) : super(SliderState.initial());

  @override
  Stream<SliderState> mapEventToState(SliderEvent event) async* {
    try {
      yield SliderState.loading();
      final slidersData = await repository.fetchSliderItems();

      yield SliderState.success(
        slidersData
      );
    } catch (ex) {
      yield SliderState.error(ex);
    }
  }
}