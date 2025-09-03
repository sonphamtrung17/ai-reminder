import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_response.freezed.dart';

part 'data_response.g.dart';

@Freezed(genericArgumentFactories: true)
sealed class DataResponse<T> with _$DataResponse<T> {
  const factory DataResponse({@JsonKey(name: 'data') T? data}) = _DataResponse;

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$DataResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
sealed class DataListResponse<T> with _$DataListResponse<T> {
  const factory DataListResponse({@JsonKey(name: 'data') List<T>? data}) =
      _DataListResponse;

  factory DataListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$DataListResponseFromJson(json, fromJsonT);
}
