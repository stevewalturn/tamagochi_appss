import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_appss/app/app.router.dart';
import 'package:tamagochi_appss/l10n/supported_locales.dart';
import 'package:tamagochi_appss/observer/screen_observer.dart';
import 'package:tamagochi_appss/ui/views/app/app_viewmodel.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: AppViewModel.new,
      builder: (_, __, ___) {
        return const _App();
      },
    );
  }
}

class _App extends ViewModelWidget<AppViewModel> {
  const _App();

  @override
  Widget build(BuildContext context, AppViewModel viewModel) {
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      minScaleFactor: 0.5,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          /// Unfocus and hide keyboard when tap on white spaces
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver,
            ScreenObserver(),
          ],
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
        ),
      ),
    );
  }
}
