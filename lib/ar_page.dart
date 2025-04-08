import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:marine_ar_explorer/models/model_loader.dart';
import 'package:marine_ar_explorer/models/marine_animal.dart';
import 'package:marine_ar_explorer/widgets/species_card.dart';
import 'package:marine_ar_explorer/widgets/ar_controls.dart';

class ARViewPage extends StatefulWidget {
  const ARViewPage({super.key});

  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> {
  ARKitController? arkitController;
  ArCoreController? arcoreController;
  String? selectedSpeciesId;
  MarineAnimal? selectedAnimal;
  double modelScale = 1.0;
  bool showInfo = false;
  String? currentNodeName;
  Map<String, ARKitNode> arKitNodes = {};

  @override
  void dispose() {
    arkitController?.dispose();
    arcoreController?.dispose();
    super.dispose();
  }

  void _onARKitViewCreated(ARKitController controller) {
    arkitController = controller;
    _addInitialInstructions();
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arcoreController = controller;
    _addInitialInstructions();
  }

  void _addInitialInstructions() {
    // Here you would typically add instructions node for users
    // For this demo, we'll just prepare the AR view
  }

  void _resetView() {
    if (Platform.isIOS && arkitController != null) {
      // Instead of calling removeNode, remove the node from the scene
      if (currentNodeName != null && arKitNodes.containsKey(currentNodeName)) {
        arkitController!.remove(arKitNodes[currentNodeName]!);
        arKitNodes.remove(currentNodeName);
      }
    } else if (arcoreController != null) {
      if (currentNodeName != null) {
        arcoreController!.removeNode(nodeName: currentNodeName!);
      }
    }
    setState(() {
      selectedSpeciesId = null;
      selectedAnimal = null;
      modelScale = 1.0;
      showInfo = false;
      currentNodeName = null;
    });
  }

  void _changeModelScale(double delta) {
    setState(() {
      modelScale = (modelScale + delta).clamp(0.5, 2.0);
      _updateModelScale();
    });
  }

  void _updateModelScale() {
    if (currentNodeName != null) {
      if (Platform.isIOS && arkitController != null && arKitNodes.containsKey(currentNodeName)) {
        // Instead of updateNode, remove and re-add with new scale
        final oldNode = arKitNodes[currentNodeName]!;
        final newNode = ARKitNode(
          geometry: oldNode.geometry,
          position: oldNode.position,
          scale: Vector3.all(modelScale),
        );
        arkitController!.remove(oldNode);
        arkitController!.add(newNode);
        arKitNodes[currentNodeName!] = newNode;
      } else if (arcoreController != null) {
        // Scale update for ArCore would go here
        // Typically requires removing and re-adding the node with new scale
      }
    }
  }

  void _toggleInfoOverlay(bool show) {
    setState(() {
      showInfo = show;
    });
  }

  Future<void> _load3DModel(String speciesId) async {
    setState(() {
      showInfo = false;
    });
    
    final animals = MarineAnimal.getSampleAnimals();
    final animal = animals.firstWhere(
      (a) => a.id == speciesId,
      orElse: () => animals.first,
    );
    
    setState(() {
      selectedSpeciesId = speciesId;
      selectedAnimal = animal;
    });

    // Clear previous nodes
    if (currentNodeName != null) {
      if (Platform.isIOS && arkitController != null && arKitNodes.containsKey(currentNodeName)) {
        arkitController!.remove(arKitNodes[currentNodeName]!);
        arKitNodes.remove(currentNodeName);
      } else if (arcoreController != null) {
        arcoreController!.removeNode(nodeName: currentNodeName!);
      }
    }

    currentNodeName = "model_$speciesId";
    
    final texture = await ModelLoader.loadAITexture(speciesId);
    
    if (Platform.isIOS && arkitController != null) {
      // For a real implementation, you would load the GLB model properly
      // This is a simplified version with a basic shape
      final material = ARKitMaterial(
        diffuse: ARKitMaterialProperty.color(Colors.blue), // Default color
        doubleSided: true,
      );
      
      final node = ARKitNode(
        name: currentNodeName!,
        geometry: ARKitSphere(
          radius: 0.1,
          materials: [material],
        ),
        position: Vector3(0, 0, -0.5),
        scale: Vector3.all(modelScale),
      );
      arkitController!.add(node);
      arKitNodes[currentNodeName!] = node;
    } else if (arcoreController != null) {
      final node = ArCoreReferenceNode(
        name: currentNodeName!,
        objectUrl: animal.modelPath,
        position: Vector3(0, 0, -1),
        scale: Vector3.all(modelScale),
      );
      arcoreController!.addArCoreNode(node);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marine AR Explorer'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // AR View
          Platform.isIOS
              ? ARKitSceneView(onARKitViewCreated: _onARKitViewCreated)
              : ArCoreView(onArCoreViewCreated: _onArCoreViewCreated),
          
          // AR Controls
          ARControlPanel(
            onReset: _resetView,
            onScaleChanged: _changeModelScale,
            onInfoToggled: _toggleInfoOverlay,
          ),
          
          // Info Overlay
          if (showInfo && selectedAnimal != null)
            AnimalInfoOverlay(
              title: selectedAnimal!.name,
              description: selectedAnimal!.description,
              onClose: () => _toggleInfoOverlay(false),
            ),
          
          // Species Selection Panel
          Positioned(
            bottom: 0,
            child: SpeciesSelectionPanel(
              onSpeciesSelected: _load3DModel,
            ),
          ),
        ],
      ),
    );
  }
} 