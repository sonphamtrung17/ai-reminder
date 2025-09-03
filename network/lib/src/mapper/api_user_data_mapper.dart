import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

@Injectable()
class ApiUserDataMapper extends BaseDataMapper<ApiUserData, User> {
  ApiUserDataMapper();

  @override
  User mapToEntity(ApiUserData? data) {
    return User(
      id: data?.id ?? User.defaultId,
      email: data?.email ?? User.defaultEmail,
      // birthday:
      //     DateTimeUtils.tryParse(
      //       date: data?.birthday,
      //       format: DateTimeFormatConstants.appServerResponse,
      //     ) ??
      //     User.defaultBirthday,
      // avatar: data?.avatar ?? '',
      // photos: _apiImageUrlDataMapper.mapToListEntity(data?.photos),
      // gender: _genderDataMapper.mapToEntity(data?.gender),
    );
  }
}
