import 'package:flutter/material.dart';
import 'package:tamagochi_appss/models/pet.dart';
import 'package:tamagochi_appss/ui/common/app_colors.dart';

class PetStatusBar extends StatelessWidget {
  final Pet pet;

  const PetStatusBar({
    required this.pet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatusBar('Health', pet.health, kcHealthColor),
        const SizedBox(height: 8),
        _buildStatusBar('Happiness', pet.happiness, kcHappinessColor),
        const SizedBox(height: 8),
        _buildStatusBar('Energy', pet.energy, kcEnergyColor),
        const SizedBox(height: 8),
        _buildStatusBar('Hunger', pet.hunger, kcHungerColor),
      ],
    );
  }

  Widget _buildStatusBar(String label, double value, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 10,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 40,
          child: Text(
            '${value.toInt()}%',
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
