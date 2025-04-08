# Marine Biology AR Explorer

A Flutter application that showcases 3D marine animal models in augmented reality for educational purposes.

## Features

- Cross-platform AR implementation (iOS with ARKit and Android with ARCore)
- Interactive 3D models of marine animals
- Educational information about marine species
- Model scaling and rotation controls
- Clean, modern UI design

## Project Structure

```
marine_ar_explorer/
├── lib/
│   ├── main.dart          # Main app entry
│   ├── ar_page.dart       # AR view implementation
│   ├── models/            # 3D model management
│   │   ├── marine_animal.dart
│   │   └── model_loader.dart
│   └── widgets/           # UI components
│       ├── species_card.dart
│       └── ar_controls.dart
├── assets/
│   ├── models/            # 3D model files (.glb)
│   │   ├── octopus.glb
│   │   ├── clownfish.glb
│   │   └── coral.glb
│   └── icons/             # UI icons
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Xcode (for iOS development)
- Android Studio (for Android development)
- A physical device for AR testing (AR cannot run on simulators)

### Installation

1. Clone the repository
```bash
git clone https://github.com/ParvePalial/DeepSeaDive.git
cd DeepSeaDive
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## AR Implementation

This project uses:
- ARKit plugin for iOS
- ARCore Flutter plugin for Android

The app demonstrates loading and displaying 3D GLB models with textures in an AR environment.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
