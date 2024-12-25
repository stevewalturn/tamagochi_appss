import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_appss/models/enums/pet_type.dart';

class PetStoreSheet extends StatelessWidget {
  final Function(SheetResponse) completer;
  final SheetRequest request;

  const PetStoreSheet({
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choose Your Pet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: PetType.values
                .map(
                  (type) => _PetOption(
                    type: type,
                    onSelected: () => completer(
                      SheetResponse(data: type),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _PetOption extends StatelessWidget {
  final PetType type;
  final VoidCallback onSelected;

  const _PetOption({
    required this.type,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              type.emoji,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 8),
            Text(
              type.displayName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
