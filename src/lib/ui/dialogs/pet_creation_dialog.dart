import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_appss/models/enums/pet_type.dart';
import 'package:tamagochi_appss/services/pet_service.dart';
import 'package:tamagochi_appss/app/app.locator.dart';

class PetCreationDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PetCreationDialog({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  State<PetCreationDialog> createState() => _PetCreationDialogState();
}

class _PetCreationDialogState extends State<PetCreationDialog> {
  final _petService = locator<PetService>();
  final _nameController = TextEditingController();
  PetType? _selectedType;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _createPet() async {
    setState(() => _errorMessage = null);

    if (_nameController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Please enter a name for your pet');
      return;
    }

    if (_selectedType == null) {
      setState(() => _errorMessage = 'Please select a pet type');
      return;
    }

    try {
      await _petService.createPet(
        name: _nameController.text.trim(),
        type: _selectedType!,
      );
      widget.completer(DialogResponse(confirmed: true));
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Create Your Pet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Pet Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: PetType.values
                  .map(
                    (type) => ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(type.emoji),
                          const SizedBox(width: 8),
                          Text(type.displayName),
                        ],
                      ),
                      selected: type == _selectedType,
                      onSelected: (selected) {
                        setState(() => _selectedType = selected ? type : null);
                      },
                    ),
                  )
                  .toList(),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _createPet,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Create Pet',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
