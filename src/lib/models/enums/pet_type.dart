enum PetType {
  cat,
  dog,
  bird,
  fish,
  hamster;

  String get displayName {
    switch (this) {
      case PetType.cat:
        return 'Cat';
      case PetType.dog:
        return 'Dog';
      case PetType.bird:
        return 'Bird';
      case PetType.fish:
        return 'Fish';
      case PetType.hamster:
        return 'Hamster';
    }
  }

  String get emoji {
    switch (this) {
      case PetType.cat:
        return '🐱';
      case PetType.dog:
        return '🐶';
      case PetType.bird:
        return '🐦';
      case PetType.fish:
        return '🐠';
      case PetType.hamster:
        return '🐹';
    }
  }
}
