import 'package:data/common/config.dart';
import 'package:data/common/dio_client.dart';
import 'package:data/models/section_model.dart';

class SectionRepository {
  List<Section> _cacheSection = [
    Section(
        id: 1,
        name: "Sobre Ximena",
        urlImage: "resources/about.webp",
        route: "sobre-ximena"),
    Section(
        id: 2,
        name: "Entrenamiento",
        urlImage: "resources/training.webp",
        route: "retos"),
    Section(
        id: 3,
        name: "Recetas",
        urlImage: "resources/recipes.webp",
        route: "recetas"),
    Section(
        id: 4,
        name: "Tips",
        urlImage: "resources/tips.webp",
        route: "articulos")
  ];

  Future<List<Section>> fetchSection() {
    if (_cacheSection.isNotEmpty) {
      return Future.value(_cacheSection.toList());
    }

    return _fetchSectionRemotely().then((value) {
      _cacheSection = value;
      return value;
    });
  }

  Future<List<Section>> _fetchSectionRemotely() {
    var client = createHttpClient(token: "");
    client.options.baseUrl = URL_BASE;

    return client
        .get('/sections')
        .then((value) => value.data as List? ?? List.empty())
        .then((value) => value.map((e) => Section.fromJson(e)).toList());
  }
}
