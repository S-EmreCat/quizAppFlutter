import 'package:dio/dio.dart';
import 'service_constants.dart';

class QuestionService {
  static QuestionService? _instance;
  static QuestionService get instance {
    if (_instance != null) return _instance!;
    _instance = QuestionService._init();
    return _instance!;
  }

  late final Dio dio;

  QuestionService._init() {
    dio = Dio(BaseOptions(baseUrl: ServiceConstants.urlCustom));
  }
}
