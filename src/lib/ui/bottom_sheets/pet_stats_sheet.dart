import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_appss/models/pet.dart';

class PetStatsSheet extends StatelessWidget {
  final Function(SheetResponse) completer;
  final SheetRequest request;

  const PetStatsSheet({
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pet = request.data as Pet;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                pet.type.emoji,
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      pet.type.displayName,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _StatRow('Status', pet.status),
          _StatRow(
            'Last Fed',
            _formatTimeAgo(pet.lastFed),
            showWarning: pet.needsFeeding,
          ),
          _StatRow(
            'Last Played',
            _formatTimeAgo(pet.lastPlayed),
            showWarning: pet.needsPlay,
          ),
          _StatRow(
            'Last Slept',
            _formatTimeAgo(pet.lastSlept),
            showWarning: pet.needsSleep,
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () => completer(SheetResponse()),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showWarning;

  const _StatRow(
    this.label,
    this.value, {
    this.showWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: showWarning ? Colors.orange : Colors.grey,
              ),
            ),
          ),
          if (showWarning)
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 20,
            ),
        ],
      ),
    );
  }
}
