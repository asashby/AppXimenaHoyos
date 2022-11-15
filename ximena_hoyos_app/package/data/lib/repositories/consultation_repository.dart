import 'package:data/repositories/base_repository.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';

class ConsultationRepository extends BaseRepository{

  ConsultationRepository(TokenStore tokenStore): super(tokenStore, API_CMS);


  Future sendNutritionalConsultation(dynamic body) async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    return client.post('/api/client-consultation', 
      data: body
    );
  }
}