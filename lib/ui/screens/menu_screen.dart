import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/settings_view_model.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  Widget _menuButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,

      child: ElevatedButton.icon(
        onPressed: onPressed,

        icon: Icon(icon),

        label: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsVM = context.watch<SettingsViewModel>();

    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 40, 137, 193),
              Color.fromARGB(255, 25, 90, 130),
            ],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Icon(Icons.grid_on, size: 50, color: Colors.white),

                const SizedBox(height: 16),

                const Text(
                  'BUSCAMINAS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  '¡Hola, ${settingsVM.username}!',
                  style: const TextStyle(fontSize: 15, color: Colors.white70),
                ),

                const SizedBox(height: 20),

                _menuButton(
                  context: context,
                  text: 'Jugar',
                  icon: Icons.play_arrow,

                  onPressed: () {
                    Navigator.pushNamed(context, '/game');
                  },
                ),

                const SizedBox(height: 16),

                _menuButton(
                  context: context,
                  text: 'Ajustes',
                  icon: Icons.settings,

                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),

                const SizedBox(height: 16),

                _menuButton(
                  context: context,
                  text: 'Historial',
                  icon: Icons.history,

                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                ),

                const SizedBox(height: 16),

                _menuButton(
                  context: context,
                  text: 'Acerca de',
                  icon: Icons.info_outline,

                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
