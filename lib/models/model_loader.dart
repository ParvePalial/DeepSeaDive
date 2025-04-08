import 'package:flutter/services.dart';
import 'dart:io';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:marine_ar_explorer/models/marine_animal.dart';

class ModelLoader {
  static Future<dynamic> loadAITexture(String speciesId) async {
    // In a real project, this would call your AI model API
    // For demo, we use bundled textures
    final animals = MarineAnimal.getSampleAnimals();
    final animal = animals.firstWhere(
      (animal) => animal.id == speciesId,
      orElse: () => animals.first,
    );
    
    if (Platform.isIOS) {
      final byteData = await rootBundle.load(animal.texturePath);
      return ARKitMaterialProperty.image(byteData.buffer.asUint8List());
    } else {
      // For Android, we return the texture path
      return animal.texturePath;
    }
  }

  static List<String> getAvailableSpecies() {
    return MarineAnimal.getSampleAnimals().map((animal) => animal.id).toList();
  }
  
  static Future<String> getModelPath(String speciesId) async {
    final animals = MarineAnimal.getSampleAnimals();
    final animal = animals.firstWhere(
      (animal) => animal.id == speciesId,
      orElse: () => animals.first,
    );
    return animal.modelPath;
  }
} 