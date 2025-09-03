import 'package:injectable/injectable.dart';
import 'package:network/src/mapper/base/base_error_response_mapper.dart';

import 'package:shared/shared.dart';

@Injectable()
class JsonArrayErrorResponseMapper
    extends BaseErrorResponseMapper<List<dynamic>> {
  @override
  ServerError mapToServerError(List<dynamic>? data) {
    return ServerError(
      errors:
          data
              ?.map(
                (jsonObject) => ServerErrorDetail(
                  serverStatusCode: jsonObject['code'] as int?,
                  message: jsonObject['message'] as String?,
                ),
              )
              .toList(growable: false) ??
          [],
    );
  }
}
