import 'package:dio/dio.dart';

import '../utils/constants.dart';

class ApiManager {
  Dio dio = Dio();
  Future<Response> getData(String endPoint) {
    return dio.get(Constants.basURl + endPoint);
  }

  Future<Response> postData(String endPoint, {Map<String, dynamic>? body}) {
    return dio.post(Constants.basURl + endPoint, data: body);
  }
}
