import 'package:equatable/equatable.dart';
import 'package:tamagochi_appss/models/enums/pet_type.dart';

class Pet extends Equatable {
  const Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.happiness,
    required this.hunger,
    required this.health,
    required this.energy,
    required this.lastFed,
    required this.lastPlayed,
    required this.lastSlept,
    this.isDead = false,
  });

  final String id;
  final String name;
  final PetType type;
  final double happiness;
  final double hunger;
  final double health;
  final double energy;
  final DateTime lastFed;
  final DateTime lastPlayed;
  final DateTime lastSlept;
  final bool isDead;

  Pet copyWith({
    String? id,
    String? name,
    PetType? type,
    double? happiness,
    double? hunger,
    double? health,
    double? energy,
    DateTime? lastFed,
    DateTime? lastPlayed,
    DateTime? lastSlept,
    bool? isDead,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      happiness: happiness ?? this.happiness,
      hunger: hunger ?? this.hunger,
      health: health ?? this.health,
      energy: energy ?? this.energy,
      lastFed: lastFed ?? this.lastFed,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      lastSlept: lastSlept ?? this.lastSlept,
      isDead: isDead ?? this.isDead,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        happiness,
        hunger,
        health,
        energy,
        lastFed,
        lastPlayed,
        lastSlept,
        isDead,
      ];

  bool get needsFeeding => DateTime.now().difference(lastFed).inHours >= 4;
  bool get needsPlay => DateTime.now().difference(lastPlayed).inHours >= 6;
  bool get needsSleep => DateTime.now().difference(lastSlept).inHours >= 8;

  String get status {
    if (isDead) return 'Dead';
    if (health < 20) return 'Very Sick';
    if (health < 40) return 'Sick';
    if (hunger > 80) return 'Starving';
    if (happiness < 20) return 'Depressed';
    if (energy < 20) return 'Exhausted';
    if (happiness > 80) return 'Happy';
    return 'Normal';
  }
}
