import 'package:injectable/injectable.dart';
import 'package:smart_notes/data/api/api_config.dart';

@module
abstract class ApiConfigModule {
  @singleton
  ApiConfig getApiConfig(/*AppFlavor flavor*/) {
    final baseUrl = 'http://the/api/base/url';

    final apiConfig = ApiConfig(
      baseUrl: baseUrl,
    );

    return apiConfig;
  }
}
