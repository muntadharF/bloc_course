import 'package:dio/dio.dart';

import '../../constants/app_strings.dart';

class CharacterWebServices {
  late final Dio dio;

  CharacterWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: AppStrings.baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try { // TODO: move strings to strings
      Response respnose = await dio.get('character');
      return respnose.data['results'];
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }
}
