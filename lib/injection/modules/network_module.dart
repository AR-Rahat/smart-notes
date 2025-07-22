import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_notes/data/api/api_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// For authentication (sign in, sign up, public api).
const dioForAuthentication = 'FOR_AUTHENTICATION';

/// For the authenticated endpoints.
const dioAuthenticated = 'AUTHENTICATED_DIO';

/// For authenticator
const authDioClient = 'AUTH_DIO_CLIENT';

Dio _createBaseDio(ApiConfig apiConfig) {
  final dio = Dio()
    ..httpClientAdapter = HttpClientAdapter()
    ..options.baseUrl = apiConfig.baseUrl
    ..options.headers['Accept'] = 'application/json'
    ..options.contentType = 'application/json';

  return dio;
}

final logger = PrettyDioLogger(
  requestHeader: true,
  requestBody: true,
  logPrint: (object) {
    if (kDebugMode) {
      log(object.toString());
    }
  },
);

@module
abstract class NetworkModule {
  @singleton
  @Named(authDioClient)
  Dio getAuthDioClient(
    ApiConfig apiConfig,
  ) {
    final dio = _createBaseDio(apiConfig)
      ..interceptors.addAll(
        [
          logger,
        ],
      );
    return dio;
  }

  @singleton
  @Named(dioForAuthentication)
  Dio getForAuthenticationDio(
    ApiConfig apiConfig,
  ) {
    final dio = _createBaseDio(apiConfig)
      ..interceptors.addAll(
        [
          logger,
        ],
      );
    return dio;
  }

  @singleton
  @Named(dioAuthenticated)
  Dio getAuthenticatedServiceAccountsDio(
    ApiConfig apiConfig,
  ) {
    final dio = _createBaseDio(apiConfig)
      ..interceptors.addAll(
        [
          logger,
        ],
      );

    return dio;
  }
}
