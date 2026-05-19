import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/mine_cell.dart';
import '../screens/about.dart';
import 'package:flutter_application_1/viewmodels/game_view_model.dart';
import '../../viewmodels/settings_view_model.dart';

class MinesweeperScreen extends StatelessWidget {
  const MinesweeperScreen({Key? key}) : super(key: key);

  Widget _gameBoard(GameViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1.0, // Cuadrado perfecto
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(), // Bloquea el scroll
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: viewModel.gridSize,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: viewModel.cells.length,
            itemBuilder: (context, index) {
              return MineCell(
                cell: viewModel.cells[index],
                onTap: () => viewModel.revealCell(index),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GameViewModel>();
    final settingsVM = context.watch<SettingsViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscaminas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        // Protege la UI de los bordes del dispositivo
        child: Column(
          // Apila el marcador arriba y el tablero abajo
          children: [
            // Área de Status
            Container(
              height: 60,
              color: Colors.grey[300],
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      viewModel.isGameOver ? 'GAME OVER' : 'Buscaminas',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'T: ${viewModel.secondsElapsed}s',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Text('Dificultad: ${settingsVM.difficulty}'),
            Text('Grid: ${settingsVM.gridSize}'),
            // Área de Juego
            Expanded(
              // Expande el tablero para llenar la pantalla
              child: _gameBoard(viewModel),
            ),
          ],
        ),
      ),
    );
  }
}
