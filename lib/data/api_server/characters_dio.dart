import 'package:dio/dio.dart';
import '../../shared/constant/strings.dart';


class CharactersDio {
  late Dio dio;

  CharactersDio() {
    BaseOptions options = BaseOptions(
        baseUrl: AppStrings.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 20 * 1000,
        connectTimeout: 20 * 1000
    );
    dio = Dio(options);
  }

   Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuote(String characterName) async {
    try {
      Response response = await dio.get('quote',queryParameters: {'author' : characterName});
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
