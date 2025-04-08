import 'package:flutter/material.dart';

class ARControlPanel extends StatelessWidget {
  final VoidCallback onReset;
  final Function(double) onScaleChanged;
  final Function(bool) onInfoToggled;

  const ARControlPanel({
    super.key,
    required this.onReset,
    required this.onScaleChanged,
    required this.onInfoToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: Column(
        children: [
          _buildControlButton(
            icon: Icons.refresh,
            onPressed: onReset,
            tooltip: 'Reset View',
          ),
          const SizedBox(height: 16),
          _buildControlButton(
            icon: Icons.zoom_in,
            onPressed: () => onScaleChanged(0.1),
            tooltip: 'Increase Size',
          ),
          const SizedBox(height: 8),
          _buildControlButton(
            icon: Icons.zoom_out,
            onPressed: () => onScaleChanged(-0.1),
            tooltip: 'Decrease Size',
          ),
          const SizedBox(height: 16),
          _buildControlButton(
            icon: Icons.info_outline,
            onPressed: () => onInfoToggled(true),
            tooltip: 'Show Information',
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        tooltip: tooltip,
        color: Colors.blue,
      ),
    );
  }
}

class AnimalInfoOverlay extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onClose;

  const AnimalInfoOverlay({
    super.key,
    required this.title,
    required this.description,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
} 