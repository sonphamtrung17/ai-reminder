import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../../core.dart';

class BottomSheetObject extends StatefulWidget {
  final Person? selectedPerson;
  final Function(Person?) onSelected;

  const BottomSheetObject({
    required this.onSelected,
    super.key,
    this.selectedPerson,
  });

  @override
  State<BottomSheetObject> createState() => _BottomSheetObjectState();
}

class _BottomSheetObjectState extends State<BottomSheetObject> {
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
      name: 'Nguyễn Tuấn 1',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 5,
      name: 'Nguyễn Tuấn 2',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 6,
      name: 'Nguyễn Tuấn 3',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 7,
      name: 'Nguyễn Tuấn 4',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
    const Person(
      id: 8,
      name: 'Nguyễn Tuấn 5',
      relationship: 'Bạn Thân',
      avatar: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              S.current.doiTuong,
              style: context.textStyle.headingXsBold.black(context),
            ),
            const Spacer(),
            AppButton.icon(
              padding: EdgeInsets.zero,
              iconPath: Assets.icons.icClose,
              backgroundColor: Colors.transparent,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        Space.h12(),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_, index) => Divider(
              color: context.color.gray1,
              height: 1,
            ),
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) {
              if (index == _persons.length) {
                return InkWell(
                  onTap: () {
                    widget.onSelected(null);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      AppImage.asset(path: Assets.icons.icAdd),
                      Space.w12(),
                      Text(
                        S.current.taoDoiTuongMoi,
                        style: context.textStyle.bodyLMedium.primary(context),
                      ),
                    ],
                  ).wrapPadding(const EdgeInsets.symmetric(vertical: 16)),
                );
              }

              final person = _persons[index];
              return InkWell(
                onTap: () {
                  widget.onSelected(person);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 76,
                  child: Row(
                    children: [
                      AppImage.circle(
                        size: Dimens.d44,
                        url: person.avatar,
                        boxFit: BoxFit.cover,
                      ),
                      Space.w12(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              person.name,
                              style: context.textStyle.bodyLSemiBold.black(context),
                            ),
                            Text(
                              person.relationship,
                              style: context.textStyle.bodySMedium.gray8(context),
                            ),
                          ],
                        ),
                      ),
                      if (widget.selectedPerson?.id == person.id)
                        AppImage.asset(
                          path: Assets.icons.icEventCheck,
                        ),
                    ],
                  ),
                ),
              );
            },
            itemCount: _persons.length + 1,
          ),
        ),
      ],
    ).wrapPadding(const EdgeInsets.all(16));
  }
}
