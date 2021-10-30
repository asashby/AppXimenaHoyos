class CompanyResponse {
  final int statusCode;
  final Company? data;

  CompanyResponse.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'],
        data = Company.parseFromJson(json['data']);
}

class Company {
  final int id;
  final String name;
  final String code;
  final String slug;
  final CompanyInfo companyInfo;
  final String? commerceToken;
  final String commerceCode;
  final int commerceId;
  final String commerceName;
  final CompanyAdditional helpCenter;
  final CompanyAdditional privacyPolicy;
  final int unitId;

  static Company? parseFromJson(dynamic data) {
    if (data == null) {
      return null;
    } else {
      return Company.fromJson(data);
    }
  }

  Company.fromJson(dynamic data)
      : id = data['id'] ?? -1,
        name = data['name'] ?? '',
        code = data['code'] ?? '',
        slug = data['slug'] ?? '',
        commerceCode = data['commerceCode'] ?? '',
        commerceId = data['commerceId'] ?? -1,
        commerceName = data['commerceName'] ?? '',
        unitId = data['unitId'] ?? 0,
        helpCenter = CompanyAdditional.fromJson(data['helpCenter'] ?? {}),
        companyInfo = CompanyInfo.fromJson(data['companyInfo'] ?? {}),
        privacyPolicy = CompanyAdditional.fromJson(data['privacyPolicy'] ?? {}),
        commerceToken = data['commerce_token'];
}

class CompanyInfo {
  final String? urlIcon;
  final String? urlLogo;
  final String? urlCompany;
  final String? companyPhone;
  final String? companyAddress;

  CompanyInfo.fromJson(dynamic data)
      : urlIcon = data['url_icon'],
        urlLogo = data['url_logo'],
        urlCompany = data['url_company'],
        companyPhone = data['company_phone'],
        companyAddress = data['company_address'];
}

class CompanyAdditional {
  final String slug;
  final String title;
  final String seoImage;
  final String seoTitle;
  final String description;
  final String seoDescription;

  CompanyAdditional.fromJson(dynamic data)
      : slug = data['slug'] ?? '',
        title = data['title'] ?? '',
        seoImage = data['seoTitle'] ?? '',
        seoTitle = data['seoTitle'] ?? '',
        description = data['description'],
        seoDescription = data['seoDescription'];
}
