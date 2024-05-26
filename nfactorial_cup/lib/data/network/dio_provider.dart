import 'dart:developer';
// import 'package:nfactorial_cup/helpers/exception.dart';
import 'package:dio/dio.dart';

enum UrlType { gpt, geocode, places, scraper }

class DioProvider {
  final UrlType type;

  DioProvider({this.type = UrlType.gpt});
  Dio get() {
    String rootUrl = '';
    switch (type) {
      case UrlType.gpt:
        rootUrl = 'https://api.openai.com/v1/';
      case UrlType.places:
        rootUrl =
            'https://search-maps.yandex.ru/v1/?apikey=7b90f117-de53-4643-afad-5efa08a0193a&lang=en_US';
      case UrlType.geocode:
        rootUrl =
            'https://geocode-maps.yandex.ru/1.x?apikey=89f5ec56-4fe3-4613-961c-5538a3d4fd19';
      case UrlType.scraper:
        rootUrl = 'https://yonder-parser.onrender.com/';
      default:
    }
    BaseOptions options = BaseOptions(
      baseUrl: rootUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    );

    final dio = Dio(options);

    dio.options.baseUrl = '';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['accept'] = 'application/json';

    if (type == UrlType.gpt) {
      dio.options.headers['Authorization'] =
          'Bearer sk-proj-Znf1v7pHmafzekSQu3mgT3BlbkFJWHY2cJ4Cgflgus5Q3LA6';
    }

    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        // print('dwadwad: ${error.type},${error.message},');
        log('❌❌❌❌❌❌---------------------------------❌❌❌❌❌❌');
        log('| REQUEST ERROR:');
        log('|    🟡 URL: ${error.requestOptions.uri}');
        log('|    🟡 DATA: ${error.requestOptions.data}');
        log('|    🟡 PARAMETERS: ${error.requestOptions.queryParameters}');
        log('|    🟡 RESPONSE: ${error.response}');
        log('|    🟡 MESSAGE: ${error.message}');
        log('❌❌❌❌❌❌---------------------------------❌❌❌❌❌❌');
        log('\n');
      },
      onRequest: (options, handler) {
        // if (options.data != null) {
        //   if (options.data['id_model'] != null) {
        //     options.path = '${options.path}${options.data['id_model']}/';
        //     options.data = null;
        //   }
        // }

        // if (options.headers['Id'] != null) {
        //   options.path = '${options.path}${options.headers['Id']}/';
        //   options.headers.remove('Id');
        // }
        options.baseUrl = rootUrl;

        log('🚀🚀🚀---------------------------------🚀🚀🚀');
        log('| REQUEST SENT:');
        log('|    🟡 FULL URL: ${options.uri.toString()}');
        log('|    🟡 PARAMETERS: ${options.data.toString()}');
        log('|    🟡 PATH/QUERY: ${options.path.toString()}');
        log('|    🟡 HEADERS: ${options.headers.toString()}');
        log('🚀🚀🚀---------------------------------🚀🚀🚀');
        log('\n');
        handler.next(options);
      },
      onResponse: (e, handler) {
        //   if (e.data['error'] != null) {
        //     final serverError = ServerErrorException.fromJson(e.data['error']);
        //     log('-----------------❌❌❌❌❌❌-----------------');
        //     log('| RESPONSE RECIEVED:');
        //     log('|    🔴 REQUEST: ${e.realUri.toString()}');
        //     log('|    🔴 DATA: ${e.data.toString()}');
        //     log('-----------------❌❌❌❌❌-----------------');
        //     log('\n');
        //     throw serverError;
        //   } else {
        //     log('-----------------✅✅✅✅✅-----------------');
        //     log('| RESPONSE RECIEVED:');
        //     log('|    🟢 REQUEST: ${e.realUri.toString()}');
        //     log('|    🟢 DATA: ${e.data.toString()}');
        //     log('-----------------✅✅✅✅✅-----------------');
        //     log('\n');
        //     handler.next(e);
        //   }
        log('-----------------✅✅✅✅✅-----------------');
        log('| RESPONSE RECIEVED:');
        log('|    🟢 REQUEST: ${e.realUri.toString()}');
        log('|    🟢 DATA: ${e.data.toString()}');
        log('-----------------✅✅✅✅✅-----------------');
        log('\n');
        handler.next(e);
      },
    ));

    return dio;
  }
}
