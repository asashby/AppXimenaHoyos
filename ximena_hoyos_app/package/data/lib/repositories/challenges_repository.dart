import 'package:data/models/challenge_detail.dart';
import 'package:data/models/challenge_header_model.dart';
import 'package:data/models/challenge_plan.dart';
import 'package:data/models/challenges_exercises_model.dart';
import 'package:data/models/comment_model.dart';
import 'package:data/models/current_courses_model.dart';
import 'package:data/models/exercise_model.dart';
import 'package:data/models/page_model.dart';
import 'package:data/repositories/base_repository.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';
import '../models/shop_product.dart';

class ChallengesRepository extends BaseRepository {
  ChallengesRepository(TokenStore tokenStore) : super(tokenStore, API_CMS);

  Future<List<ChallengeHeader>> fetchChallenges(int page) async {
    final client = await this.dio;

    return client
        .get('/api/courses', queryParameters: {'page': page})
        .then(
            (value) => Page.fromJson(value.data as Map<String, dynamic>? ?? {}))
        .then((value) =>
            value.data!.map((e) => ChallengeHeader.fromJson(e)).toList());
  }

  Future<List<ChallengeHeader>> fetchChallengesByUser(
      int userId, int page) async {
    final client = await this.dio;

    return client
        .get('/api/courses-by-user', queryParameters: {'page': page})
        .then(
            (value) => Page.fromJson(value.data as Map<String, dynamic>? ?? {}))
        .then((value) =>
            value.data!.map((e) => ChallengeHeader.fromJson(e)).toList());
  }

  /// Obtener el detalle del reto en funcion al slug de la cabecera
  Future<ChallengeDetail> fetchChallengeDetail(String slug) async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    final response = await client.get('/api/courses/$slug/detail-user');
    return ChallengeDetail.fromJson(response.data);
  }

  /// Obtener el detalle del reto en funcion al slug de la cabecera
  Future<CurrentCourses> fetchCurrentCourses() async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    final response = await client.get('/api/current/courses');
    return CurrentCourses.fromJson(response.data);
  }

  /// Obtener los planes del reto del reto
  Future<ChallengePlan> fetchChallengePlans(String slug) async {
    
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    var response = await client.get('/api/course/$slug/plans-list');

    return ChallengePlan.fromJson(response.data);
  }

  /// Obtener la listas de rutinas diarias del reto
  /// slug - slug de la cabecera del reto
  Future<List<ChallengesDailyRoutine>> fetchRoutineByChallenge(
      String slug) async {
    var client = await this.dio;
    return client.get('/api/courses/$slug/units').then((result) =>
        (result.data as List? ?? List.empty())
            .map((e) => ChallengesDailyRoutine.fromJson(e))
            .toList());
  }

  /// Detalle de la rutina del reto
  /// este recibe como parametro el slug de la rutina y el id de este
  Future<ExcerciseHeader?> fetchDayExcersise(
      String challengeSlug, int routineId) async {
    var client = await this.dio;
    var response = await client.get('/api/units/$challengeSlug/detail',
        queryParameters: {'course_id': routineId});

    if (response.data == null) {
      return null;
    }

    return ExcerciseHeader.fromJson(response.data);
  }

  /// Lista de ejercicios de la rutina diaria
  /// este recibe como parametro el id de la cabecera
  /// de los ejercicios.
  Future<List<Excercise>> fetchExcercisesRoutines(int dayId) async {
    var client = await this.dio;
    var response = await client.get('/api/units/$dayId/questions');

    return (response.data as List? ?? [])
        .map((e) => Excercise.fromJson(e))
        .toList();
  }

  Future<ExerciseDetail?> fetchRoutine(Excercise exercise) async {
    var client = await this.dio;
    var response = await client.get('/api/questions/${exercise.code}/detail');

    if (response.data == null) {
      return null;
    }

    return ExerciseDetail.fromJson(response.data);
  }

  Future finishSet(int unitId, int questionId, int setNumber) async {
    final client = await this.dio;
    await client.post('/api/questions/final', data: {
      'unit_id': unitId,
      'question_id': questionId,
      'set_number': setNumber
    });
  }

  Future<List<Comment>> fetchComments(String slug) async {
    final client = await this.dio;
    final response = await client.get('/api/comments/course/$slug');
    return (response.data as List? ?? []).map((e) => Comment.from(e)).toList();
  }

  Future postComment(
      {required String challengeSlug,
      required double rating,
      required String title,
      required String content}) async {
    final client = await this.dio;
    final body = {'rating': rating, 'title': title, 'content': content};
    await client.post('/api/rating/course/$challengeSlug', data: body);
  }

  Future suscribeToChallenge(int id) async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    return client.patch('/api/courses/payment', 
      data: {
        'orderId': 1234,
        'link': 'http://127.0.0.1:8000/courses/basico-en-casa/payment',
        'plan_id': id
      }
    );
  }

  Future registerOrderWithPromoData(List<int?> shopPromoItems, List<ShopProduct> shopProducts, double totalPrice) async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    return client.patch('/api/courses/payment', 
      data: {
        'orderId': 1234,
        'link': 'http://127.0.0.1:8000/courses/basico-en-casa/payment',
        'product_id': shopPromoItems,
        'line_items': shopProducts,
        'total': totalPrice
      }
    );
  }

  Future registerOrderData(List<ShopProduct> shopProducts, double totalPrice) async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    return client.patch('/api/courses/payment', 
      data: {
        'orderId': 1234,
        'link': 'http://127.0.0.1:8000/courses/basico-en-casa/payment',
        'line_items': shopProducts,
        'total': totalPrice
      }
    );
  }
}
