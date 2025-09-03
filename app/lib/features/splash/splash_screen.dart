import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/splash/splash_cubit.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseScreenState<SplashScreen, SplashCubit> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            // commonCubit.onLoadingVisibilityEmitted(isLoading: false);
            // commonCubit.onLoadingVisibilityEmitted(isLoading: true);
            // print(dotenv.env['API_URL']);
          },
          child: const Text('Press me'),
        ),
      ),
    );
  }
}
