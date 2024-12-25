import 'package:stacked/stacked.dart';
import 'package:tamagochi_appss/models/enums/pet_type.dart';
import 'package:tamagochi_appss/models/pet.dart';

class PetService implements InitializableDependency {
  Pet? _currentPet;
  Pet? get currentPet => _currentPet;

  @override
  Future<void> init() async {
    // Initialize service - could load saved pet from storage in the future
  }

  Future<void> createPet({
    required String name,
    required PetType type,
  }) async {
    if (name.isEmpty) {
      throw Exception('Pet name cannot be empty');
    }

    final now = DateTime.now();
    _currentPet = Pet(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      type: type,
      happiness: 100,
      hunger: 0,
      health: 100,
      energy: 100,
      lastFed: now,
      lastPlayed: now,
      lastSlept: now,
    );
  }

  Future<void> feed() async {
    if (_currentPet == null) {
      throw Exception('No pet exists');
    }
    if (_currentPet!.isDead) {
      throw Exception('Cannot feed a dead pet');
    }

    _currentPet = _currentPet!.copyWith(
      hunger: (_currentPet!.hunger - 30).clamp(0, 100),
      health: (_currentPet!.health + 10).clamp(0, 100),
      lastFed: DateTime.now(),
    );
  }

  Future<void> play() async {
    if (_currentPet == null) {
      throw Exception('No pet exists');
    }
    if (_currentPet!.isDead) {
      throw Exception('Cannot play with a dead pet');
    }
    if (_currentPet!.energy < 20) {
      throw Exception('Pet is too tired to play');
    }

    _currentPet = _currentPet!.copyWith(
      happiness: (_currentPet!.happiness + 20).clamp(0, 100),
      energy: (_currentPet!.energy - 20).clamp(0, 100),
      hunger: (_currentPet!.hunger + 10).clamp(0, 100),
      lastPlayed: DateTime.now(),
    );
  }

  Future<void> sleep() async {
    if (_currentPet == null) {
      throw Exception('No pet exists');
    }
    if (_currentPet!.isDead) {
      throw Exception('A dead pet cannot sleep');
    }

    _currentPet = _currentPet!.copyWith(
      energy: 100,
      health: (_currentPet!.health + 20).clamp(0, 100),
      lastSlept: DateTime.now(),
    );
  }

  Future<void> updatePetStatus() async {
    if (_currentPet == null || _currentPet!.isDead) return;

    final now = DateTime.now();
    final hoursSinceLastFed = now.difference(_currentPet!.lastFed).inHours;
    final hoursSinceLastPlayed =
        now.difference(_currentPet!.lastPlayed).inHours;
    final hoursSinceLastSlept = now.difference(_currentPet!.lastSlept).inHours;

    var newHunger = _currentPet!.hunger + (hoursSinceLastFed * 5);
    var newHappiness = _currentPet!.happiness - (hoursSinceLastPlayed * 3);
    var newEnergy = _currentPet!.energy - (hoursSinceLastSlept * 4);
    var newHealth = _currentPet!.health;

    if (newHunger > 80) newHealth -= 10;
    if (newHappiness < 20) newHealth -= 5;
    if (newEnergy < 10) newHealth -= 8;

    _currentPet = _currentPet!.copyWith(
      hunger: newHunger.clamp(0, 100),
      happiness: newHappiness.clamp(0, 100),
      energy: newEnergy.clamp(0, 100),
      health: newHealth.clamp(0, 100),
      isDead: newHealth <= 0,
    );
  }
}
