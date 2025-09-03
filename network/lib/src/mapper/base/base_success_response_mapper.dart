import 'package:shared/shared.dart';

import 'success_response/data_json_array_response_mapper.dart';
import 'success_response/data_json_object_reponse_mapper.dart';
import 'success_response/json_array_response_mapper.dart';
import 'success_response/json_object_reponse_mapper.dart';

enum SuccessResponseMapperType {
  dataJsonObject,
  dataJsonArray,
  jsonObject,
  jsonArray,
}

abstract class BaseSuccessResponseMapper<I extends Object, O extends Object> {
  const BaseSuccessResponseMapper();

  factory BaseSuccessResponseMapper.fromType(SuccessResponseMapperType type) {
    return switch (type) {
      SuccessResponseMapperType.dataJsonObject =>
        DataJsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.dataJsonArray =>
        DataJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.jsonObject =>
        JsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.jsonArray =>
        JsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
    };
  }

  O? map({required dynamic response, Decoder<I>? decoder}) {
    assert(response != null);
    try {
      return mapToDataModel(response: response, decoder: decoder);
    } on RemoteException catch (_) {
      rethrow;
    } catch (e) {
      throw RemoteException(
        kind: RemoteExceptionKind.decodeError,
        rootException: e,
      );
    }
  }

  O? mapToDataModel({required dynamic response, Decoder<I>? decoder});
}
