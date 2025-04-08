class MarineAnimal {
  final String id;
  final String name;
  final String description;
  final String modelPath;
  final String texturePath;
  final String iconPath;

  const MarineAnimal({
    required this.id,
    required this.name,
    required this.description,
    required this.modelPath,
    required this.texturePath,
    required this.iconPath,
  });

  static List<MarineAnimal> getSampleAnimals() {
    return [
      const MarineAnimal(
        id: 'octopus',
        name: 'Octopus',
        description: 'Highly intelligent cephalopod with eight arms.',
        modelPath: 'assets/models/octopus.glb',
        texturePath: 'assets/models/octopus_tex.jpg',
        iconPath: 'assets/icons/octopus_icon.png',
      ),
      const MarineAnimal(
        id: 'clownfish',
        name: 'Clownfish',
        description: 'Small, orange fish known for living in sea anemones.',
        modelPath: 'assets/models/clownfish.glb',
        texturePath: 'assets/models/clownfish_tex.jpg',
        iconPath: 'assets/icons/clownfish_icon.png',
      ),
      const MarineAnimal(
        id: 'coral',
        name: 'Coral Reef',
        description: 'Diverse underwater ecosystem built by coral polyps.',
        modelPath: 'assets/models/coral.glb',
        texturePath: 'assets/models/coral_tex.jpg',
        iconPath: 'assets/icons/coral_icon.png',
      ),
    ];
  }
} 