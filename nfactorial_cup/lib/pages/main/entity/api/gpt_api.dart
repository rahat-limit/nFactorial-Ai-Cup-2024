import 'package:dio/dio.dart';
import 'package:nfactorial_cup/data/local_db/context_storage.dart';
import 'package:nfactorial_cup/pages/main/entity/model/gpt_request.dart';

class GptApi {
  final Dio dio;
  final ContextStorage contextStorage;
  GptApi({required this.dio, required this.contextStorage});
  Future generateText(String prompt) async {
    GptRequestModel model = GptRequestModel(
        model: 'gpt-3.5-turbo',
        responseformat: ResponseFormat(type: 'json_object'),
        messages: [
          GptMessage(role: 'system', content: contextStorage.context),
          GptMessage(role: 'user', content: prompt)
        ]);
    await dio.post('https://api.openai.com/v1/chat/completions',
        data: model.toJson());
  }
}
