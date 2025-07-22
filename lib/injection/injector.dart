import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_notes/injection/injector.config.dart';

GetIt injector = GetIt.I;

@injectableInit
Future<void> configureDependencies() async => injector.init();
