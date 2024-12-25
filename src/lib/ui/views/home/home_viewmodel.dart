import 'dart:async';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_appss/app/app.dialogs.dart';
import 'package:tamagochi_appss/app/app.locator.dart';
import 'package:tamagochi_appss/models/pet.dart';
import 'package:tamagochi_appss/services/pet_service.dart';

class HomeViewModel extends BaseViewModel {
  final _petService = locator<PetService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  Timer? _updateTimer;
  Pet? get pet => _petService.currentPet;

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  Future<void> initialize() async {
    if (pet == null) {
      await _showPetCreationDialog();
    }
    _startUpdateTimer();
  }

  void _startUpdateTimer() {
    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _updatePetStatus(),
    );
  }

  Future<void> _updatePetStatus() async {
    try {
      await _petService.updatePetStatus();
      if (pet?.isDead == true) {
        await _showPetDeathDialog();
      }
      rebuildUi();
    } catch (e) {
      setError('Failed to update pet status. Please try again.');
    }
  }

  Future<void> _showPetCreationDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.petCreation,
    );

    if (response?.confirmed != true) {
      setError('You need to create a pet to continue!');
      return;
    }
    rebuildUi();
  }

  Future<void> _showPetDeathDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.petDeath,
      data: pet,
    );

    if (response?.confirmed == true) {
      await _showPetCreationDialog();
    }
  }

  Future<void> feedPet() async {
    try {
      await _petService.feed();
      rebuildUi();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> playWithPet() async {
    try {
      await _petService.play();
      rebuildUi();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> putPetToSleep() async {
    try {
      await _petService.sleep();
      rebuildUi();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> showPetStats() async {
    if (pet == null) {
      setError('No pet exists to show stats for.');
      return;
    }

    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.petStats,
      data: pet,
    );
  }
}
