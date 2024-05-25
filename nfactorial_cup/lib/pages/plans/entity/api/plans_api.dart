import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nfactorial_cup/pages/plans/entity/model/menu_item_model.dart';
// import 'package:retrofit/retrofit.dart';

// part 'plans_api.g.dart';

// @RestApi()
class PlansApi {
  final Dio dio;
  final Dio scraperApi;
  PlansApi({required this.dio, required this.scraperApi});
  Future<String> sendGPTMessage(
      {required String prompt, required String context}) async {
    final List<Map<String, String>> messages = [
      {'role': 'system', 'content': context}
    ];

    messages.add({'role': 'user', 'content': prompt});

    final res = await dio.post('/chat/completions',
        data: jsonEncode({
          "model": "gpt-4o",
          "messages": messages,
        }));

    if (res.statusCode == 200) {
      String content = res.data['choices'][0]['message']['content'];
      // content = content.trim();

      // messages.add({
      //   'role': 'assistant',
      //   'content': content,
      // });
      return content;
    }
    return 'An internal error occurred';
  }

  Future<GetMenuContext?> getMenuContext({required int placeId}) async {
    final res = await scraperApi.get('?id=$placeId');

    if (res.statusCode != 200) return null;
    GetMenuContext menuContext = GetMenuContext.fromJson(res.data);
    return menuContext;
  }
}
