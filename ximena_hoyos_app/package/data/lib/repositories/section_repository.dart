import 'package:data/common/config.dart';
import 'package:data/common/dio_client.dart';
import 'package:data/models/section_model.dart';

class SectionRepository {
  List<Section> _cacheSection = [
    Section(
        id: 1,
        name: "Sobre Ximena",
        urlImage: "resources/OP01.webp",
        route: "sobre-ximena"),
    Section(
        id: 2,
        name: "Entrenamiento",
        urlImage: "resources/OP02.webp",
        route: "retos"),
    Section(
        id: 3,
        name: "Recetas",
        urlImage: "resources/OP03.webp",
        route: "recetas"),
    Section(
        id: 4,
        name: "Tips",
        urlImage: "resources/OP04.webp",
        route: "articulos")
  ];

  Future<List<Section>> fetchSection() {
    
    return Future.value(_cacheSection.toList());
    /*if (_cacheSection.isNotEmpty) {
      return Future.value(_cacheSection.toList());
    }

    return _fetchSectionRemotely().then((value) {
      _cacheSection = value;
      return value;
    });*/
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
