// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'body')
  String? get descr => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call({int id, String? title, @JsonKey(name: 'body') String? descr});
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? descr = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      descr: freezed == descr
          ? _value.descr
          : descr // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostModelImplCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$$PostModelImplCopyWith(
          _$PostModelImpl value, $Res Function(_$PostModelImpl) then) =
      __$$PostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? title, @JsonKey(name: 'body') String? descr});
}

/// @nodoc
class __$$PostModelImplCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$PostModelImpl>
    implements _$$PostModelImplCopyWith<$Res> {
  __$$PostModelImplCopyWithImpl(
      _$PostModelImpl _value, $Res Function(_$PostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? descr = freezed,
  }) {
    return _then(_$PostModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      descr: freezed == descr
          ? _value.descr
          : descr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostModelImpl implements _PostModel {
  const _$PostModelImpl(
      {required this.id,
      required this.title,
      @JsonKey(name: 'body') this.descr});

  factory _$PostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostModelImplFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  @JsonKey(name: 'body')
  final String? descr;

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, descr: $descr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.descr, descr) || other.descr == descr));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, descr);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      __$$PostModelImplCopyWithImpl<_$PostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostModelImplToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  const factory _PostModel(
      {required final int id,
      required final String? title,
      @JsonKey(name: 'body') final String? descr}) = _$PostModelImpl;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$PostModelImpl.fromJson;

  @override
  int get id;
  @override
  String? get title;
  @override
  @JsonKey(name: 'body')
  String? get descr;
  @override
  @JsonKey(ignore: true)
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) {
  return _PostResponse.fromJson(json);
}

/// @nodoc
mixin _$PostResponse {
  List<PostModel> get posts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostResponseCopyWith<PostResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostResponseCopyWith<$Res> {
  factory $PostResponseCopyWith(
          PostResponse value, $Res Function(PostResponse) then) =
      _$PostResponseCopyWithImpl<$Res, PostResponse>;
  @useResult
  $Res call({List<PostModel> posts});
}

/// @nodoc
class _$PostResponseCopyWithImpl<$Res, $Val extends PostResponse>
    implements $PostResponseCopyWith<$Res> {
  _$PostResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
  }) {
    return _then(_value.copyWith(
      posts: null == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostResponseImplCopyWith<$Res>
    implements $PostResponseCopyWith<$Res> {
  factory _$$PostResponseImplCopyWith(
          _$PostResponseImpl value, $Res Function(_$PostResponseImpl) then) =
      __$$PostResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PostModel> posts});
}

/// @nodoc
class __$$PostResponseImplCopyWithImpl<$Res>
    extends _$PostResponseCopyWithImpl<$Res, _$PostResponseImpl>
    implements _$$PostResponseImplCopyWith<$Res> {
  __$$PostResponseImplCopyWithImpl(
      _$PostResponseImpl _value, $Res Function(_$PostResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
  }) {
    return _then(_$PostResponseImpl(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostResponseImpl implements _PostResponse {
  const _$PostResponseImpl({required final List<PostModel> posts})
      : _posts = posts;

  factory _$PostResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostResponseImplFromJson(json);

  final List<PostModel> _posts;
  @override
  List<PostModel> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  String toString() {
    return 'PostResponse(posts: $posts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostResponseImpl &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_posts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostResponseImplCopyWith<_$PostResponseImpl> get copyWith =>
      __$$PostResponseImplCopyWithImpl<_$PostResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostResponseImplToJson(
      this,
    );
  }
}

abstract class _PostResponse implements PostResponse {
  const factory _PostResponse({required final List<PostModel> posts}) =
      _$PostResponseImpl;

  factory _PostResponse.fromJson(Map<String, dynamic> json) =
      _$PostResponseImpl.fromJson;

  @override
  List<PostModel> get posts;
  @override
  @JsonKey(ignore: true)
  _$$PostResponseImplCopyWith<_$PostResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
