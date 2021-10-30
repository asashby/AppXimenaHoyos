enum Provider { google, facebook }

extension ProviderValue on Provider {
  int get value {
    switch (this) {
      case Provider.google:
        return 2;
      case Provider.facebook:
        return 3;
    }
  }

  String get name {
    switch (this) {
      case Provider.google:
        return 'Google';
      case Provider.facebook:
        return 'Facebook';
    }
  }
}

abstract class ProviderHelper {
  ProviderHelper._();

  static Provider? parse(String name) {
    return Provider.values.cast<Provider?>().firstWhere(
        (element) => name.toLowerCase() == element!.name.toLowerCase(),
        orElse: () => null);
  }
}
