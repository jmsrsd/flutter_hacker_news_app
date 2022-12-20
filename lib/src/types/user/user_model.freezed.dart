// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String? get about => throw _privateConstructorUsedError;
  int? get created => throw _privateConstructorUsedError;
  int? get delay => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  int? get karma => throw _privateConstructorUsedError;
  List<int>? get submitted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String? about,
      int? created,
      int? delay,
      String? id,
      int? karma,
      List<int>? submitted});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? about = freezed,
    Object? created = freezed,
    Object? delay = freezed,
    Object? id = freezed,
    Object? karma = freezed,
    Object? submitted = freezed,
  }) {
    return _then(_value.copyWith(
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as int?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      karma: freezed == karma
          ? _value.karma
          : karma // ignore: cast_nullable_to_non_nullable
              as int?,
      submitted: freezed == submitted
          ? _value.submitted
          : submitted // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? about,
      int? created,
      int? delay,
      String? id,
      int? karma,
      List<int>? submitted});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? about = freezed,
    Object? created = freezed,
    Object? delay = freezed,
    Object? id = freezed,
    Object? karma = freezed,
    Object? submitted = freezed,
  }) {
    return _then(_$_UserModel(
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as int?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      karma: freezed == karma
          ? _value.karma
          : karma // ignore: cast_nullable_to_non_nullable
              as int?,
      submitted: freezed == submitted
          ? _value._submitted
          : submitted // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  _$_UserModel(
      {this.about,
      this.created,
      this.delay,
      this.id,
      this.karma,
      final List<int>? submitted})
      : _submitted = submitted;

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String? about;
  @override
  final int? created;
  @override
  final int? delay;
  @override
  final String? id;
  @override
  final int? karma;
  final List<int>? _submitted;
  @override
  List<int>? get submitted {
    final value = _submitted;
    if (value == null) return null;
    if (_submitted is EqualUnmodifiableListView) return _submitted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserModel(about: $about, created: $created, delay: $delay, id: $id, karma: $karma, submitted: $submitted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.karma, karma) || other.karma == karma) &&
            const DeepCollectionEquality()
                .equals(other._submitted, _submitted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, about, created, delay, id, karma,
      const DeepCollectionEquality().hash(_submitted));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  factory _UserModel(
      {final String? about,
      final int? created,
      final int? delay,
      final String? id,
      final int? karma,
      final List<int>? submitted}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String? get about;
  @override
  int? get created;
  @override
  int? get delay;
  @override
  String? get id;
  @override
  int? get karma;
  @override
  List<int>? get submitted;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
