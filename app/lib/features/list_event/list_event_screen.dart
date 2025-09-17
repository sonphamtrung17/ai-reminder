import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/list_event/list_event_cubit.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';
import 'components/event_of_day.dart';
import 'components/upcoming_event.dart';

@RoutePage()
class ListEventScreen extends StatefulWidget {
  const ListEventScreen({super.key});

  @override
  State<ListEventScreen> createState() => _ListEventScreenState();
}

class _ListEventScreenState extends BaseScreenState<ListEventScreen, ListEventCubit> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: '',
        backgroundColor: Colors.transparent,
        showBack: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'T4, 23/08/2025',
              style: context.textStyle.bodyXlSemiBold,
            ),
            const Space(height: Dimens.d12),
            const UpcomingEvent(),
            const Space(height: Dimens.d20),
            const EventOfDay(),
            Space.h100(),
          ],
        ),
      ).wrapPadding(const EdgeInsets.symmetric(horizontal: Dimens.d16)),
    );
  }
}

const String url =
    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*';
