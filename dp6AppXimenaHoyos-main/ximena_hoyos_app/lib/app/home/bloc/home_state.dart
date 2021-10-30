import 'package:data/models/profile_model.dart';
import 'package:data/models/section_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Section> section;
  final Profile? user;

  const HomeSuccess(this.section, this.user);

  @override
  List<Object> get props => [section];
}

class HomeError extends HomeState {
  final Exception error;

  const HomeError(this.error);

  @override
  List<Object> get props => [error];
}
