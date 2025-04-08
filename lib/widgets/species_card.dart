import 'package:flutter/material.dart';
import 'package:marine_ar_explorer/models/model_loader.dart';
import 'package:marine_ar_explorer/models/marine_animal.dart';

class SpeciesSelectionPanel extends StatelessWidget {
  final Function(String) onSpeciesSelected;

  const SpeciesSelectionPanel({super.key, required this.onSpeciesSelected});

  @override
  Widget build(BuildContext context) {
    final animals = MarineAnimal.getSampleAnimals();
    
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: animals.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (ctx, index) {
          final animal = animals[index];
          return SpeciesCard(
            animal: animal,
            onTap: () => onSpeciesSelected(animal.id),
          );
        },
      ),
    );
  }
}

class SpeciesCard extends StatelessWidget {
  final MarineAnimal animal;
  final VoidCallback onTap;

  const SpeciesCard({
    super.key,
    required this.animal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        width: 100,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                animal.iconPath,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 40);
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              animal.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
} 