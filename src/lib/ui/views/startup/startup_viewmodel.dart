import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_appss/app/app.locator.dart';
import 'package:tamagochi_appss/app/app.router.dart';
import 'package:tamagochi_appss/services/pet_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _petService = locator<PetService>();

  Future<void> runStartupLogic() async {
    try {
      await _petService.init();
      await Future.delayed(const Duration(seconds: 2));
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      setError('Failed to initialize the application. Please try again.');
    }
  }
}
