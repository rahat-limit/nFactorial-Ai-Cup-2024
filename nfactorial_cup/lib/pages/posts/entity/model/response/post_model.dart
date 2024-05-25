import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required int id,
    required String? title,
    @JsonKey(name: 'body') String? descr,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, Object?> json) =>
      _$PostModelFromJson(json);
}

@freezed
class PostResponse with _$PostResponse {
  const factory PostResponse({
    required List<PostModel> posts,
  }) = _PostResponse;

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);
}
