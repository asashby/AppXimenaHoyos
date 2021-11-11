import 'package:data/models/company_model.dart';
import 'package:data/common/dio_client.dart';
import 'package:data/utils/constants.dart';

class CompanyRepository {
  Company? _company; // Company Cache

  Future<Company?> getCompanyInfo({bool refresh = false}) async {
    if (!refresh && _company != null) {
      return _company;
    }

    final response =
        await createHttpClient().get('$API_CMS/api/company/public');
    final parseResponse = CompanyResponse.fromJson(response.data);

    _company = parseResponse.data;

    return _company;
  }
}
