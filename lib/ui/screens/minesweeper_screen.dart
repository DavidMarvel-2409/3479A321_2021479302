import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cell_model.dart';
import 'package:logger/logger.dart';
import '../widgets/mine_cell.dart';
import '../screens/about.dart';

class MinesweeperScreen extends StatefulWidget {
  const MinesweeperScreen({Key? key}) : super(key: key);

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  late List<CellModel> _cells;
  final logger = Logger();

  @override
  void initState() {
    super.initState();

    _cells = List.generate(64, (i) => CellModel(index: i));

    logger.i('Lifecycle: initState() - El estado ha sido creado.');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    logger.i(
      'Lifecycle: didChangeDependencies() - Contexto listo o dependencias cambiadas.',
    );
  }

  @override
  void didUpdateWidget(covariant MinesweeperScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    logger.w(
      'Lifecycle: didUpdateWidget() - La configuración del widget ha cambiado.',
    );
  }

  @override
  void dispose() {
    logger.e(
      'Lifecycle: dispose() - El estado se destruye. Liberando memoria.',
    );

    super.dispose();
  }

  void _onCellTapped(int index) {
    setState(() {
      _cells[index].isRevealed = true;
    });
  }

  Widget _gameBoard() {
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
            itemCount: _cells.length,
            itemBuilder: (context, index) {
              return MineCell(
                cell: _cells[index],
                onTap: () => _onCellTapped(index),
              );
              /*return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  border: Border.all(color: Colors.grey[600]!, width: 1.5),
                ),
              );*/
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // Definimos valores por defecto (Fallback) en caso de que lleguen nulos
    final String difficulty = args?['difficulty'] ?? 'Desconocida';
    final int gridSize = args?['gridSize'] ?? 8; //
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
              child: const Center(
                child: Text(
                  'STATUS: 349 segundos | Minas: 10 | Cuadros: 56',
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
              child: _gameBoard(),
            ),
          ],
        ),
      ),
    );
  }
}
