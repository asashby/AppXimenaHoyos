import 'package:data/data.dart';
import 'package:data/repositories/company_repository.dart';
import 'package:data/repositories/section_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/home/bloc/home_event.dart';
import 'package:ximena_hoyos_app/app/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SectionRepository repository;
  final AuthenticationDataSource authenticationRepository;
  final CompanyRepository companyRepository;

  HomeBloc(
      {required this.companyRepository,
      required this.repository,
      required this.authenticationRepository})
      : super(HomeLoading()) {
    add(HomeFetchSection());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeFetchSection) {
      yield HomeLoading();
      yield await _mapHomeFetchSectionToState();
    }
  }

  Future<HomeState> _mapHomeFetchSectionToState() async {
    try {
      final sections = await repository.fetchSection();
      // Obtener y mantener en memoria la informacion de la compania
      await companyRepository.getCompanyInfo();
      final user = await authenticationRepository.user;
      return HomeSuccess(sections, user);
    } on Exception catch (e) {
      return HomeError(e);
    }
  }
}
