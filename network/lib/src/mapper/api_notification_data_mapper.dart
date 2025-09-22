import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

@Injectable()
class ApiNotificationDataMapper extends BaseDataMapper<ApiNotificationData, NotificationEntity> {
  ApiNotificationDataMapper();

  @override
  NotificationEntity mapToEntity(ApiNotificationData? data) {
    return NotificationEntity(
      id: data?.id ?? NotificationEntity.defaultId,
      title: data?.title ?? '',
      message: data?.message ?? '',
      isRead: data?.isRead ?? false,
      createdAt: data?.createdAt ?? '',
      // email: data?.email ?? User.defaultEmail,
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
