import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/list_interest/list_interest_cubit.dart';
import '../../components/components.dart';
import '../../resource/resource.dart';
import '../../theme/theme.dart';

@RoutePage()
class ListInterestScreen extends StatefulWidget {
  const ListInterestScreen({super.key});

  @override
  State<ListInterestScreen> createState() => _ListInterestScreenState();
}

class _ListInterestScreenState extends BaseScreenState<ListInterestScreen, ListInterestCubit>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  final List<Person> _persons = [
    const Person(
      id: 1,
      name: 'Nguyễn Thảo',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 2,
      name: 'Trung Sơn',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 3,
      name: 'Trần Tuấn',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 4,
      name: 'Nguyễn Tuấn',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 4,
      name: 'Nguyễn Tuấn',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 4,
      name: 'Nguyễn Tuấn',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 4,
      name: 'Nguyễn Tuấn',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 4,
      name: 'Nguyễn Tuấn',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
  ];

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backgroundColor: Colors.transparent,
        title: S.current.doiTuongQuanTam,
        showBack: true,
        actions: [
          AppButton.textIcon(
            text: S.current.tao,
            textStyle: context.textStyle.bodyMSemiBold.black(context),
            iconPath: Assets.icons.icAdd,
            backgroundColor: Colors.transparent,
            spacing: Dimens.d4,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: context.color.white
        ),
        child: ListView.separated(
          itemCount: _persons.length,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: context.color.gray1,
              height: Dimens.d1,
              thickness: Dimens.d1,
            );
          },
          itemBuilder: (context, index) {
            final item = _persons[index];
            return Slidable(
              key: ValueKey(item.id),
              startActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                children: [
                  CustomSlidableAction(
                    onPressed: (context) => doSomething(context),
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Icon(Icons.delete, size: Dimens.d30, color: context.color.red),
                    ),
                  ),
                ],
              ),
              child: SizedBox(
                height: Dimens.d70,
                child: _itemInterest(context, item),
              ),
            );
          },
        ),
      ).wrapPadding(const EdgeInsets.all(Dimens.d16)),
    );
  }

  void doSomething(BuildContext context) {}

  Widget _itemInterest(BuildContext context, Person item) {
    return Row(
      children: [
        AppImage.circle(
          size: Dimens.d44,
          url: item.avatar,
          boxFit: BoxFit.cover,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: context.textStyle.bodyLSemiBold.black(context),
              ),
              Text(
                item.relationship,
                style: context.textStyle.bodySMedium.black(context),
              ),
            ],
          ).wrapPadding(const EdgeInsets.symmetric(horizontal: Dimens.d12)),
        ),
        AppButton.icon(
          iconPath: Assets.icons.icEdit,
          backgroundColor: Colors.transparent,
        ),
      ],
    ).wrapPadding(const EdgeInsets.symmetric(horizontal: Dimens.d12, vertical: Dimens.d13));
  }
}
