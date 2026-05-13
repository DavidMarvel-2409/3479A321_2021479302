import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/cell_model.dart';
// import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../widgets/mine_cell.dart';
import '../screens/about.dart';
import 'package:flutter_application_1/viewmodels/game_view_model.dart';

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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8, // 8 columnas
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
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // Definimos valores por defecto (Fallback) en caso de que lleguen nulos
    final String difficulty = args?['difficulty'] ?? 'Desconocida';
    final int gridSize = args?['gridSize'] ?? 8;
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
                child: Text(
                  viewModel.isGameOver ? 'GAME OVER' : 'Buscaminas en curso',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const Divider(height: 1),
            Text('Dificultad: $difficulty'),
            Text('Grid: $gridSize'),
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
