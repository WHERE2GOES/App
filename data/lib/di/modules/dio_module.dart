import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @injectable
  Dio getDio() => Dio();
}
