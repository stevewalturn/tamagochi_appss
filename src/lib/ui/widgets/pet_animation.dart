import 'package:flutter/material.dart';
import 'package:tamagochi_appss/models/pet.dart';

class PetAnimation extends StatelessWidget {
  final Pet pet;

  const PetAnimation({
    required this.pet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main pet emoji
          Text(
            pet.type.emoji,
            style: TextStyle(
              fontSize: 100,
              color: pet.isDead ? Colors.grey : null,
            ),
          ),
          // Status indicator
          if (!pet.isDead)
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pet.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (pet.status.toLowerCase()) {
      case 'happy':
        return Colors.green;
      case 'normal':
        return Colors.blue;
      case 'starving':
        return Colors.orange;
      case 'sick':
      case 'very sick':
        return Colors.red;
      case 'depressed':
        return Colors.purple;
      case 'exhausted':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }
}
