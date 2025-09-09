import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'configure_dependencies.config.dart';

@InjectableInit()
Future<void> configureDependencies() async {
  GetIt.instance.init();
}