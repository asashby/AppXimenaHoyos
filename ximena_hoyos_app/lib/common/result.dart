import 'package:equatable/equatable.dart';

class Result extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ResultLoading extends Result {}

class ResultError extends Result {
  final dynamic error;
  ResultError(this.error) : super();
}

class ResultSuccess extends Result {
  final dynamic data;
  ResultSuccess(this.data);
}
