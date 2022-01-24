import 'package:data/models/profile_model.dart';
import 'package:data/repositories/tips_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State class

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final Profile? data;
  final ProfileStatus status;
  final Exception? exception;
  final bool isUpdated;

  const ProfileState._(this.status,
      {this.data, this.exception, this.isUpdated = false});

  const ProfileState.initial() : this._(ProfileStatus.initial);
  const ProfileState.loading() : this._(ProfileStatus.loading);
  const ProfileState.success(Profile data, {bool isUpdated = false})
      : this._(ProfileStatus.success, data: data, isUpdated: isUpdated);
  const ProfileState.error(Exception exception)
      : this._(ProfileStatus.error, exception: exception);

  @override
  List<Object?> get props => [data, status, exception];
}

// Event class

abstract class ProfileEvent extends Equatable {}

class FetchProfileEvent extends ProfileEvent {
  FetchProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final String? name;
  final String? lastName;
  final String email;
  final int? age;
  final int? weight;
  final int? size;
  final ProfileGoal? goal;

  UpdateProfileEvent(this.name, this.lastName, this.email, this.age,
      this.weight, this.size, this.goal);

  @override
  List<Object?> get props => [name, lastName, email, age, weight, size, goal];
}

// Bloc Class

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final TipsRepository repository;

  ProfileGoal? currentGoal;
  int? currentAge;
  int? currentSize;
  int? currentWeight;

  ProfileBloc(this.repository) : super(ProfileState.initial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchProfileEvent) {
      yield* _fetchEventToState();
    } else if (event is UpdateProfileEvent) {
      yield* _updateEventToState(event);
    }
  }

  Stream<ProfileState> _updateEventToState(UpdateProfileEvent event) async* {
    yield ProfileState.loading();
    try {
      final updateRaw = ProfileUpdateRaw(
          additional: ProfileInformationAdditional.build(
              event.age, event.size, event.weight),
          goal: event.goal,
          lastName: event.lastName,
          name: event.name);
      await repository.updateProfile(updateRaw);
      yield* _fetchEventToState(isUpdated: true);
    } on Exception catch (e) {
      yield ProfileState.error(e);
    }
  }

  Stream<ProfileState> _fetchEventToState({bool isUpdated = false}) async* {
    yield ProfileState.loading();
    try {
      final profile = await repository.fetchProfile();

      if (profile == null) {
        throw ProfileNotFoundException();
      }

      currentGoal = profile.goal;
      currentAge = profile.additionalInformation!.age;
      currentSize = profile.additionalInformation!.size;
      currentWeight = profile.additionalInformation!.weight;

      yield ProfileState.success(profile, isUpdated: isUpdated);
    } on Exception catch (e) {
      yield ProfileState.error(e);
    }
  }
}

class ProfileNotFoundException implements Exception {}
