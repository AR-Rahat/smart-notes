import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DataModule {
  // If we want to pre-await the future and register its resolved value,
  // we should annotate our async dependencies with @preResolve.
  @preResolve
  @singleton
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

}
