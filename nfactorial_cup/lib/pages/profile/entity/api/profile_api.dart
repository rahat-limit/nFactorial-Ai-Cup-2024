import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';

// part 'plans_api.g.dart';

// @RestApi()
class ProfileApi {
  final Dio dio;
  ProfileApi({required this.dio});
  Future getProfile() async {
    // final List<Map<String, String>> messages = [];

    // messages.add({'role': 'user', 'content': prompt});

    // final res = await dio.post('/chat/completions',
    //     data: jsonEncode({
    //       "model": "gpt-3.5-turbo",
    //       "messages": messages,
    //     }));

    // if (res.statusCode == 200) {
    //   String content = jsonDecode(res.data)['choices'][0]['message']['content'];
    //   content = content.trim();

    //   messages.add({
    //     'role': 'assistant',
    //     'content': content,
    //   });
    //   return content;
    // }
    // return 'An internal error occurred';
  }
}
