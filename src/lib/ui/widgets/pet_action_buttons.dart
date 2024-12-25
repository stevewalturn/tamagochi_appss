import 'package:flutter/material.dart';
import 'package:tamagochi_appss/models/pet.dart';

class PetActionButtons extends StatelessWidget {
  final Pet pet;
  final VoidCallback onFeed;
  final VoidCallback onPlay;
  final VoidCallback onSleep;
  final VoidCallback onStats;

  const PetActionButtons({
    required this.pet,
    required this.onFeed,
    required this.onPlay,
    required this.onSleep,
    required this.onStats,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _ActionButton(
          icon: Icons.restaurant,
          label: 'Feed',
          onTap: onFeed,
          isDisabled: pet.isDead,
          showAlert: pet.needsFeeding,
        ),
        _ActionButton(
          icon: Icons.sports_esports,
          label: 'Play',
          onTap: onPlay,
          isDisabled: pet.isDead || pet.energy < 20,
          showAlert: pet.needsPlay,
        ),
        _ActionButton(
          icon: Icons.bedtime,
          label: 'Sleep',
          onTap: onSleep,
          isDisabled: pet.isDead,
          showAlert: pet.needsSleep,
        ),
        _ActionButton(
          icon: Icons.bar_chart,
          label: 'Stats',
          onTap: onStats,
          isDisabled: false,
          showAlert: false,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDisabled;
  final bool showAlert;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDisabled,
    required this.showAlert,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: isDisabled ? Colors.grey[300] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: isDisabled ? 0 : 2,
          child: InkWell(
            onTap: isDisabled ? null : onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 32,
                    color: isDisabled ? Colors.grey : Colors.black,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: isDisabled ? Colors.grey : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showAlert && !isDisabled)
          const Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 24,
            ),
          ),
      ],
    );
  }
}
