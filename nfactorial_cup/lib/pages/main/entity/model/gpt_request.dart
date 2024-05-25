class GptMessage {
  String? role;
  String? content;

  GptMessage({this.role, this.content});

  GptMessage.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['role'] = role;
    data['content'] = content;
    return data;
  }
}

class ResponseFormat {
  String? type;

  ResponseFormat({this.type});

  ResponseFormat.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    return data;
  }
}

class GptRequestModel {
  String? model;
  ResponseFormat? responseformat;
  List<GptMessage?>? messages;

  GptRequestModel({this.model, this.responseformat, this.messages});

  GptRequestModel.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    responseformat = json['response_format'] != null
        ? ResponseFormat?.fromJson(json['response_format'])
        : null;
    if (json['messages'] != null) {
      messages = <GptMessage>[];
      json['messages'].forEach((v) {
        messages!.add(GptMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['model'] = model;
    data['response_format'] = responseformat!.toJson();
    data['messages'] =
        messages != null ? messages!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
