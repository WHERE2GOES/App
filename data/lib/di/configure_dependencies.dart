import 'package:data/di/locator.dart';
import 'package:injectable/injectable.dart';

import 'configure_dependencies.config.dart';

@InjectableInit()
void configureDependencies() => locator.init();
